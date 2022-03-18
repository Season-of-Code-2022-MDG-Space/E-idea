import 'dart:io';
import 'dart:math';

import 'package:assignment/assignments_screens/Thirdpage.dart';
import 'package:assignment/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:assignment/assignments_screens/FirstPage.dart';
import 'package:assignment/assignments_screens/secondPage.dart';
import 'package:assignment/assignments_screens/Modal.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MyApp8 extends StatelessWidget {
  static final String title = 'CSN-103';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll('files2/');
  }

  int a = 0;
  String result3 = ' ';
  Widget Display1() {
    if (a == 1) {
      return TextField(
        //controller: _namecontroller,
        decoration: new InputDecoration(
          hintText: 'Type here',
          //hintStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        onChanged: (String str) {
          setState(() {
            result3 = str;
          });
        },
      );
    } else
      return Text('');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp8.title),
          centerTitle: true,
        ),
        body: FutureBuilder<List<FirebaseFile>>(
          future: futureFiles,
          builder: (context, snapshot) {
            if (snapshot.hasData) {}
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Some error occurred!'));
                } else {
                  final files = snapshot.data!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildHeader(files.length),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                          itemCount: files.length,
                          itemBuilder: (context, index) {
                            final file = files[index];

                            return buildFile(context, file);
                          },
                        ),
                      ),
                    ],
                  );
                }
            }
          },
        ),
        //Display1(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MyApp5()));
            a = 1;
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
        ),
      );

  Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
        // leading: ClipOval(
        /* child: Image.network(
            file.url,
            width: 52,
            height: 52,
            fit: BoxFit.cover,
          ),
        ),*/
        title: Text(
          file.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
        ),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImagePage(file: file),
        )),
      );

  Widget buildHeader(int length) => ListTile(
        tileColor: Colors.blue,
        leading: Container(
          width: 52,
          height: 52,
          child: Icon(
            Icons.file_copy,
            color: Colors.white,
          ),
        ),
        title: Text(
          '$length Files',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      );
/*  getpdfandupload() async {
    FilePickerResult? file =
        await FilePicker.platform.pickFiles(type: FileType.custom
        allowedExtensions: ['pdf']);
    var number = Random().nextInt(20);
    if(file == null) return;
    File pick = File(file.files.single.path.toString());
    var file2 = pick.readAsBytesSync();
    String name = DateTime.now().millisecondsSinceEpoch.toString();
    //uploading file
    var pdffile = FirebaseStorage.instance.ref().child(name).child('/.pdf');
    UploadTask task = pdffile.putData(file2);
    TaskSnapshot snapshot  = await task;
    var url2 = await snapshot.ref.getDownloadURL();
    await FirebaseFirestore.instance.collection("file").doc().set({
      'fileurl':url2,
      'num':"Assignment"+number.toString(),
    });
  }
}
Future Upload() async{
 final result =
        await FilePicker.platform.pickFiles(type: FileType.custom
        allowedExtensions: ['pdf']);
    var number = Random().nextInt(20);
    if(result == null) return;
    final path = result.files.single.path;
    setState(() => file = File(path));
}*/
}
