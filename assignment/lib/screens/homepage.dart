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
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Home.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 300,
                  ),
                  const Text(
                    "Welcome back...",
                    style: TextStyle(
                        color: Color.fromARGB(255, 52, 82, 109),
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // ignore: unnecessary_string_interpolations
                  Text("$name",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 52, 82, 109),
                          fontSize: 20,
                          fontWeight: FontWeight.normal)),
                  const SizedBox(
                    height: 20,
                  ),
                  Material(
                    color: const Color.fromARGB(255, 174, 211, 228),
                    elevation: 5,
                    borderRadius: BorderRadius.circular(25),
                    child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(40, 100, 40, 100),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyApp3()),
                        );
                      },
                      child: const Text(
                        "Assignments",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 23, 83, 133),
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ActionChip(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    label: const Text(
                      "Logout",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 32, 32, 32),
                          fontWeight: FontWeight.normal),
                    ),
                    onPressed: () {
                      logout(context);
                    },
                  ),
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
