import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:securestorage/MainPage/Upload.dart';
import 'package:securestorage/Authentication/AuthenticationHelper.dart';
import 'package:securestorage/Models/Encrypt.dart';
import 'package:securestorage/Models/global.dart' as global;

import '../Models/Decrypt.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);
  @override
  Main_View createState() => Main_View();
}

class Main_View extends State<MainView> {
  String downloadurl = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload/View File"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EncryptPage()));
                },
                elevation: 8,
                child: (const Text("Upload")),
              ),
            ),
            RaisedButton(
              onPressed: (() {
                //ListExample();
                Downloadfile();
                //DecryptData.decrypt_file(downloadurl);
              }),
              textColor: Colors.white,
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Color.fromARGB(255, 77, 78, 78))),
              child: (const Text('Download')),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> ListExample() async {
  ListResult result =
      (await FirebaseStorage.instance.ref().getDownloadURL()) as ListResult;
  result.items.forEach((Reference element) {
    print('found File ============ : $element');
  });
}

Future<void> Downloadfile() async {
  Directory? dir = await getExternalStorageDirectory();
  String uid = AuthenticationHelper().inputData();
  String filename = global.filename;
  print("check filename **************************************" + filename);
  //File downloadToFile = File('${dir?.path}/deviceId.txt.aes');
  //String fileToDownload = 'amW3MdKm1Af0NlmXeCnu68c1YyP2/deviceId.txt.aes';
  File downloadToFile = File('${dir?.path}/${filename}.aes');
  String fileToDownload = uid + '/' + filename + '.aes';
  //Directory dir1= await
  /*String _localPath=await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS*/
  //String pathDownload = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
  try {
    await FirebaseStorage.instance
        .ref(fileToDownload)
        .writeToFile(downloadToFile);
    DecryptData.decrypt_file(downloadToFile.path);
    print(dir);
  } on FirebaseException catch (e) {
    print('Download error==========================================: $e');
  }
}
