import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('E-IDEA'),
        ),
        body: Center(
            child: Column(
          children: [
            TextField(controller: emailController),
            TextField(controller: passwordController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);
                      setState(() {});
                    },
                    child: Text('Sign Up')),
                ElevatedButton(
                    onPressed: () {
                      print('Welcome to E-IDEA!');
                    },
                    child: Text('Sign In')),
                ElevatedButton(onPressed: () {}, child: Text('Log Out')),
              ],
            )
          ],
        )),
      ),
    );
  }
}
