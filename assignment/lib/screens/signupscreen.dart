import 'dart:ui';

import 'package:assignment/model/usermodel.dart';
import 'package:assignment/screens/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class signupscreen extends StatefulWidget {
  const signupscreen({Key? key}) : super(key: key);

  @override
  _signupscreenState createState() => _signupscreenState();
}

class _signupscreenState extends State<signupscreen> {
  final _auth = FirebaseAuth.instance;
  @override
  final _formKey = GlobalKey<FormState>();

  final nameEditingController = new TextEditingController();
  final enrollmentEditingController = new TextEditingController();

  String value = "CSE";
  String value2 = "O1";
  final branchEditingController = new TextEditingController();
  final batchEditingController = new TextEditingController();

  final emailidEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final cpasswordEditingController = new TextEditingController();

  Widget build(BuildContext context) {
    final namefield = TextFormField(
      autofocus: false,
      controller: nameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Name cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Name(Min. 3 Characters)");
        }
        return null;
      },
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
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your email");
        }

        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
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
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
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
      validator: (value) {
        if (cpasswordEditingController.text != passwordEditingController.text) {
          return "Password don't match";
        }
        return null;
      },
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
          signup(emailidEditingController.text, passwordEditingController.text);
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
                        branchEditingController.text = newValue!;
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
                        batchEditingController.text = newValue2!;
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

  //signup function
  void signup(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postdetailstoFirestore(),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postdetailstoFirestore() async {
    //call firestore
    //call usermodel
    //sending values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    usermodel userModel = usermodel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = nameEditingController.text;
    userModel.enrollment = enrollmentEditingController.text;
    userModel.branch = branchEditingController.text;
    userModel.batch = batchEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => homepage()), (route) => false);
  }
}
