import 'package:assignment/screens/homepage.dart';
import 'package:assignment/screens/signupscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:assignment/states/CurrentUser.dart';

// ignore: camel_case_types
class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  _loginscreenState createState() => _loginscreenState();
}

// ignore: camel_case_types
class _loginscreenState extends State<loginscreen> {
  String id = "login";
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final emailfield = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please enter your email");
          }

          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!.trim();
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final passwordfield = TextFormField(
        autofocus: false,
        controller: passwordController,
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
        obscureText: true,
        onSaved: (value) {
          passwordController.text = value!;
        },
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
      color: const Color.fromARGB(255, 11, 38, 85),
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
          minWidth: 250,
          onPressed: () async {
            //loginuser(emailController.text, passwordController.text, context);

            if (_formKey.currentState!.validate()) {
              context.read<AuthenticationProvider>().loginUser(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const homepage()));
            }
          },
          child: const Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.normal),
          )),
    );

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Login.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 400,
                    ),
                    emailfield,
                    const SizedBox(
                      height: 20,
                    ),
                    passwordfield,
                    const SizedBox(
                      height: 35,
                    ),
                    loginbutton,
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 10, 53, 82),
                                fontWeight: FontWeight.normal),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const signupscreen()));
                            },
                            child: const Text(
                              "SignUp",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 10, 53, 82),
                                  fontWeight: FontWeight.normal),
                            ),
                          )
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //login function
  void loginuser(String email, String password, BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Succesful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const homepage()))
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  /*void loginuser(String email, String password, BuildContext context) async {
    currentUser _currentuser = Provider.of<currentUser>(context, listen: false);

    try {
      if (_formKey.currentState!.validate()) {
        if (await _currentuser.loginUser(email, password)) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((context) => homepage())));
        }
      }
    } catch (e) {
      print(e);
    }
  }*/
}
