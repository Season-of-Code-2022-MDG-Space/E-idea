import 'package:flutter/material.dart';
import 'package:assignment/assignments_screens/Main2.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:assignment/assignments_screens/csn103-1.dart';
import 'package:assignment/assignments_screens/csn101-1.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:my_app_assignment/main.dart';

class MyApp3 extends StatelessWidget {
  const MyApp3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Assignments'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Choose one subject'),
            ElevatedButton(
              onPressed: () {
                var push = Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp2()),
                );
              },
              child: Text('MAN-001'),
            ),
            ElevatedButton(
              onPressed: () {
                var push = Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp9()),
                );
              },
              child: Text('CSN-101'),
            ),
            ElevatedButton(
              onPressed: () {
                var push = Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp8()),
                );
              },
              child: Text('CSN-103'),
            ),
            // buildGridview(),
          ],
        ),
        // backgroundColor:Colors.deepOrange,
      ),
    );
  }
}
