import 'dart:ui';

import 'package:assignment/screens/homepage.dart';
import 'package:flutter/material.dart';

class signupscreen extends StatefulWidget {
  const signupscreen({Key? key}) : super(key: key);

  @override
  _signupscreenState createState() => _signupscreenState();
}

class _signupscreenState extends State<signupscreen> {
  @override
  final _formKey = GlobalKey<FormState>();

  final nameEditingController = new TextEditingController();
  final enrollmentEditingController = new TextEditingController();

  String value = "CSE";
  String value2 = "O1";

  final emailidEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final cpasswordEditingController = new TextEditingController();

  Widget build(BuildContext context) {
    final namefield = TextFormField(
      autofocus: false,
      controller: nameEditingController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        nameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(hintText: "Full Name"),
    );

    final enrollmentfield = TextFormField(
      autofocus: false,
      controller: enrollmentEditingController,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        enrollmentEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(hintText: "Enrollment No."),
    );

    final emailidfield = TextFormField(
      autofocus: false,
      controller: emailidEditingController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailidEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(hintText: "Email ID"),
    );

    final passwordfield = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(hintText: "Password"),
    );

    final cpasswordfield = TextFormField(
      autofocus: false,
      controller: cpasswordEditingController,
      obscureText: true,
      onSaved: (value) {
        cpasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(hintText: "Confirm Password"),
    );

    final signupbutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => homepage(),
              ));
        },
        child: Text('Sign Up'),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    namefield,
                    enrollmentfield,
                    DropdownButton<String>(
                      value: value,
                      items: const [
                        DropdownMenuItem(value: 'CSE', child: Text("CSE")),
                        DropdownMenuItem(value: 'ECE', child: Text("ECE")),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          value = newValue!;
                        });
                      },
                      hint: Text("Branch"),
                    ),
                    DropdownButton<String>(
                      value: value2,
                      items: const [
                        DropdownMenuItem(value: 'O1', child: Text("O1")),
                        DropdownMenuItem(value: 'O2', child: Text("O2")),
                        DropdownMenuItem(value: 'O3', child: Text("O3")),
                        DropdownMenuItem(value: 'O4', child: Text("O4")),
                        DropdownMenuItem(value: 'O5', child: Text("O5")),
                        DropdownMenuItem(value: 'O6', child: Text("O6")),
                        DropdownMenuItem(value: 'O7', child: Text("O7")),
                        DropdownMenuItem(value: 'O8', child: Text("O8")),
                      ],
                      onChanged: (String? newValue2) {
                        setState(() {
                          value2 = newValue2!;
                        });
                      },
                      hint: Text("Batch"),
                    ),
                    emailidfield,
                    passwordfield,
                    cpasswordfield,
                    signupbutton,
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
