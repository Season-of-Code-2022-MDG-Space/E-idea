// ignore_for_file: unnecessary_const

import 'dart:async';

import 'package:assignment/assignments_screens/Main2.dart';
import 'package:assignment/assignments_screens/Thirdpage.dart';
import 'package:flutter/material.dart';

class crpwdscreen extends StatefulWidget {
  const crpwdscreen({Key? key}) : super(key: key);

  @override
  State<crpwdscreen> createState() => _crpwdscreenState();
}

// ignore: camel_case_types
class _crpwdscreenState extends State<crpwdscreen> {
  final TextEditingController passwordController = TextEditingController();

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
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final loginbutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () {
            if (passwordController.text == "only@CRallowed") {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyApp5()));
            } else {
              const snackBar = const SnackBar(
                duration: const Duration(seconds: 2),
                content: const Text(
                    'Wrong Password : Only CR can access. Reverting..'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Timer(const Duration(seconds: 2), () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MyApp2()));
              });
            }
          },
          child: const Text(
            "Submit",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    const Text("Enter Password to upload files:"),
                    passwordfield,
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
