import 'package:assignment/assignments_screens/csn101-1.dart';
import 'package:flutter/material.dart';
import 'package:assignment/assignments_screens/Main2.dart';
import 'package:assignment/assignments_screens/csn103-1.dart';
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
      home: const MyHomePage(title: 'Assignments'),
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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/subscreen.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: GridView.count(
            padding: const EdgeInsets.all(60.0),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              const SizedBox(
                height: 500,
              ),
              const SizedBox(
                height: 500,
              ),
              SizedBox(
                height: 100, //height of button
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 176, 205, 230),
                    side: const BorderSide(
                        width: 0,
                        color: Colors.transparent), //border width and color
                    elevation: 3, //elevation of button
                    shape: RoundedRectangleBorder(
                        //to set border radius to button
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyApp2()),
                    );
                  },
                  child: const Text(
                    'MAN-001',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 10, 53, 82),
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),

              SizedBox(
                height: 100, //height of button
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 176, 205, 230),
                    side: const BorderSide(
                        width: 0,
                        color: Colors.transparent), //border width and color
                    elevation: 3, //elevation of button
                    shape: RoundedRectangleBorder(
                        //to set border radius to button
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyApp9()));
                  },
                  child: const Text(
                    'CSN-101',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 10, 53, 82),
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              SizedBox(
                height: 100, //height of button
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 176, 205, 230),
                    side: const BorderSide(
                        width: 0,
                        color: Colors.transparent), //border width and color
                    elevation: 3, //elevation of button
                    shape: RoundedRectangleBorder(
                        //to set border radius to button
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyApp8()),
                    );
                  },
                  child: const Text(
                    'CSN-103',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 10, 53, 82),
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              // buildGridview(),
            ],
          ),
          // backgroundColor:Colors.deepOrange,
        ),
      ),
    );
  }
}
