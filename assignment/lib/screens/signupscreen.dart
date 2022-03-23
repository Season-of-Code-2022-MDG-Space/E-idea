import 'package:assignment/screens/homepage.dart';
import 'package:assignment/states/CurrentUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class signupscreen extends StatefulWidget {
  const signupscreen({Key? key}) : super(key: key);

  @override
  _signupscreenState createState() => _signupscreenState();
}

// ignore: camel_case_types
class _signupscreenState extends State<signupscreen> {
  //@override
  final _formKey = GlobalKey<FormState>();

  final nameEditingController = TextEditingController();
  final enrollmentEditingController = TextEditingController();

  String value = "Branch";
  String value2 = "Batch";
  final branchEditingController = TextEditingController();
  final batchEditingController = TextEditingController();

  final emailidEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final cpasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final namefield = TextFormField(
      autofocus: false,
      controller: nameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
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
      decoration: const InputDecoration(hintText: "Full Name"),
    );

    final enrollmentfield = TextFormField(
      autofocus: false,
      controller: enrollmentEditingController,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        enrollmentEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(hintText: "Enrollment No."),
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
        emailidEditingController.text = value!.trim();
      },
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(hintText: "Email ID"),
    );

    final passwordfield = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
        return null;
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(hintText: "Password"),
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
      decoration: const InputDecoration(hintText: "Confirm Password"),
    );

    final signupbutton = Material(
      color: const Color.fromARGB(255, 17, 47, 82),
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        minWidth: 200,
        onPressed: () {
          //signup(emailidEditingController.text, passwordEditingController.text);
          if (_formKey.currentState!.validate()) {
            context.read<AuthenticationProvider>().signUpUser(
                emailidEditingController.text,
                passwordEditingController.text,
                nameEditingController.text,
                enrollmentEditingController.text,
                branchEditingController.text,
                batchEditingController.text);

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const homepage()));
          }
        },
        child: const Text(
          "Sign Up",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.normal),
        ),
      ),
    );

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Sign.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 9, 49, 82),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(55.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Hello!                        ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Nice to meet you...',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    namefield,
                    enrollmentfield,
                    DropdownButton<String>(
                      value: value,
                      items: const [
                        DropdownMenuItem(
                          value: 'Branch',
                          child: Text("Branch"),
                          enabled: false,
                        ),
                        DropdownMenuItem(value: 'CSE', child: Text("CSE")),
                        DropdownMenuItem(value: 'ECE', child: Text("ECE")),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          value = newValue!;
                        });
                        branchEditingController.text = newValue!;
                      },
                      hint: const Text("Branch"),
                    ),
                    DropdownButton<String>(
                      value: value2,
                      items: const [
                        DropdownMenuItem(
                          value: 'Batch',
                          child: Text("Batch"),
                          enabled: false,
                        ),
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
                      hint: const Text("Batch"),
                    ),
                    emailidfield,
                    passwordfield,
                    cpasswordfield,
                    const SizedBox(
                      height: 50,
                    ),
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
