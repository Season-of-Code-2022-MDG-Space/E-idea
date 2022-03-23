import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:assignment/assignments_screens/api.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class MyApp5 extends StatelessWidget {
  static const String title = 'Add Assignments';

  const MyApp5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MainPage(),
      );
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  UploadTask? task;
  File? file;

  get children => null;
  /*Widget Dateinput(){
    if()
    return TextField();
    
  }*/
  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Home.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 350,
                ),
                const Text(
                  'Add Assignment',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromARGB(255, 30, 80, 114),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                /*ButtonWidget(
                  text: 'Select File',
                  icon: Icons.attach_file,
                  onClicked: selectFile,
                ),*/
                SizedBox(
                    height: 60, //height of button
                    width: 200,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          side: const BorderSide(
                              width: 0,
                              color:
                                  Colors.transparent), //border width and color
                          elevation: 5, //elevation of button
                          shape: RoundedRectangleBorder(
                              //to set border radius to button
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: selectFile,
                        icon: const Icon(Icons.attach_file),
                        label: const Text(
                          'Select File',
                          style: TextStyle(
                              fontSize: 22,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.normal),
                        ))),
                const SizedBox(height: 15),
                Text(
                  fileName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 48),
                SizedBox(
                  height: 60, //height of button
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      side: const BorderSide(
                          width: 0,
                          color: Colors.transparent), //border width and color
                      elevation: 5, //elevation of button
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: uploadFile,
                    child: const Text(
                      'Upload',
                      style: TextStyle(
                          fontSize: 22,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                task != null ? buildUploadStatus(task!) : Container(),
                //Dateinput(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    // ignore: avoid_print
    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
