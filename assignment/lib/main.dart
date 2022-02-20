import 'package:flutter/material.dart';
import 'package:assignment/screens/loginscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'assignemnt app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loginscreen(),
    );
  }
}
