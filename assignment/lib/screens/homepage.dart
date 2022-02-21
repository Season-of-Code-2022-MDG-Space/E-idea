import 'package:assignment/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:assignment/assignments_screens/subscreen.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  User? user = FirebaseAuth.instance.currentUser;
  usermodel loggedinuser = usermodel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedinuser = usermodel.fromMap(value.data());
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Hi",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text("${loggedinuser.name}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              ElevatedButton(
                  onPressed: () {
                    var push = Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp3()),
                    );
                  },
                  child: Text("Assignments"))
            ],
          ),
        ),
      ),
    ));
  }
}
