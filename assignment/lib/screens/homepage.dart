import 'package:assignment/model/usermodel.dart';
import 'package:assignment/screens/loginscreen.dart';
import 'package:assignment/states/CurrentUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:assignment/assignments_screens/subscreen.dart';

// ignore: camel_case_types
class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

// ignore: camel_case_types
class _homepageState extends State<homepage> {
  User? user = FirebaseAuth.instance.currentUser;

  usermodel loggedinuser = usermodel();
  AuthenticationProvider obj = AuthenticationProvider(FirebaseAuth.instance);
  String name = "";

  @override
  void initState() {
    super.initState();
    obj.authState.listen((user) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .get()
          .then((value) {
        debugPrint(value.data().toString());
        loggedinuser = usermodel.fromMap(value.data());
        setState(() {
          name = loggedinuser.name!;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "HI",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text("$name",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyApp3()),
                    );
                  },
                  child: const Text("Assignments")),
              ActionChip(
                  label: const Text("Logout"),
                  onPressed: () {
                    logout(context);
                  })
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => const loginscreen())));
  }
}
