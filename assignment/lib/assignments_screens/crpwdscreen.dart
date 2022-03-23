// ignore_for_file: unnecessary_const

import 'dart:async';

import 'package:assignment/assignments_screens/Main2.dart';
import 'package:assignment/assignments_screens/Thirdpage.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class crpwdscreen extends StatefulWidget {
  const crpwdscreen({Key? key}) : super(key: key);

  @override
  State<crpwdscreen> createState() => _crpwdscreenState();
}

// ignore: camel_case_types
class _crpwdscreenState extends State<crpwdscreen> {
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final passwordfield = TextFormField(
        autofocus: false,
        controller: passwordController,
        /*if (value == "only@CRallowed") {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MyApp5()));
          } else {
            const snackBar = const SnackBar(
              duration: const Duration(seconds: 3),
              content: const Text('Wrong Password entered'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MyApp2()));
          }*/

        obscureText: true,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: " ",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final loginbutton = Material(
      color: const Color.fromRGBO(89, 160, 240, 1),
      elevation: 0,
      borderRadius: BorderRadius.circular(8),
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          onPressed: () {
            if (passwordController.text == "only@CRallowed") {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const MyApp5()));
            } else {
              const snackBar = const SnackBar(
                duration: const Duration(seconds: 2),
                content: const Text(
                    'Wrong Password: Only CR can access. Reverting..'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Timer(const Duration(seconds: 2), () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const MyApp2()));
              });
            }
          },
          child: const Text(
            "Submit",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.normal),
          )),
    );

    return Container(
      decoration: const BoxDecoration(
        image: const DecorationImage(
          image: const AssetImage('assets/Signm.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 280,
                    ),
                    const Text(
                      "Enter the password:                            ",
                      style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 10, 53, 82),
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    passwordfield,
                    const SizedBox(
                      height: 30,
                    ),
                    loginbutton
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
