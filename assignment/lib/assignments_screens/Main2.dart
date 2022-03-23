import 'package:assignment/assignments_screens/crpwdscreen.dart';
import 'package:assignment/assignments_screens/FirstPage.dart';
import 'package:assignment/assignments_screens/secondPage.dart';
import 'package:assignment/assignments_screens/showingpdf.dart';
import 'package:flutter/material.dart';

class MyApp2 extends StatelessWidget {
  static const String title = 'MAN-001';

  const MyApp2({Key? key}) : super(key: key);

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
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll('files/');
  }

  int a = 0;
  String result3 = ' ';
  // ignore: non_constant_identifier_names
  Widget Display1() {
    if (a == 1) {
      return TextField(
        //controller: _namecontroller,
        decoration: const InputDecoration(
          hintText: 'Type here',
          //hintStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        onChanged: (String str) {
          setState(() {
            result3 = str;
          });
        },
      );
    } else {
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/common.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder<List<FirebaseFile>>(
            future: futureFiles,
            builder: (context, snapshot) {
              if (snapshot.hasData) {}
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return const Center(child: Text('Some error occurred!'));
                  } else {
                    final files = snapshot.data!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 120,
                        ),
                        const Text(
                          "        " + MyApp2.title,
                          style: TextStyle(
                              fontSize: 32,
                              color: Color.fromARGB(255, 10, 53, 82),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        buildHeader(files.length),
                        const SizedBox(
                          height: 8,
                          width: 10,
                        ),
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const crpwdscreen()));
              a = 1;
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: const Color.fromARGB(255, 10, 42, 68),
          ),
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
        contentPadding: const EdgeInsets.fromLTRB(50, 10, 30, 10),
        title: Text(
          file.name,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Color.fromARGB(255, 88, 126, 158)),
        ),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImagePage(file: file),
        )),
      );

  Widget buildHeader(int length) => ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 50,
        ),
        tileColor: Colors.transparent,
        leading: const SizedBox(
          width: 60,
          height: 30,
          child: Icon(
            Icons.file_copy,
            color: Color.fromARGB(255, 36, 74, 117),
          ),
        ),
        title: Text(
          '$length Assignment(s)               ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color.fromARGB(255, 36, 74, 117),
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
