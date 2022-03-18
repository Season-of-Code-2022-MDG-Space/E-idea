import 'package:assignment/assignments_screens/FirstPage.dart';
import 'package:assignment/assignments_screens/secondPage.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ImagePage extends StatelessWidget {
  final FirebaseFile file;

  const ImagePage({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isImage = [
      '.pdf',
    ].any(file.name.contains);

    return Scaffold(
      appBar: AppBar(
        title: Text(file.name),
        centerTitle: true,
        /*actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () async {
              //  await FirebaseApi.downloadFile(file.ref);

              final snackBar = SnackBar(
                content: Text('Downloaded ${file.name}'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          const SizedBox(width: 12),
        ],*/
      ),
      body: isImage
          ? SfPdfViewer.network(
              file.url,
              // height: double.infinity,
              // fit: BoxFit.cover,
            )
          : const Center(
              child: Text(
                'Cannot be displayed',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
    );
  }
}
/*network(
              file.url,
              height: double.infinity,
              fit: BoxFit.cover,
            )*/