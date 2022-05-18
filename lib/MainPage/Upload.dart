// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:securestorage/Models/Decrypt.dart';
import 'package:securestorage/Models/Encrypt.dart';

class EncryptPage extends StatefulWidget {
  const EncryptPage({Key? key}) : super(key: key);
  @override
  Encrypt_Page createState() => Encrypt_Page();
}

class Encrypt_Page extends State<EncryptPage> {
  String _image = "";
  String path = "";

  Future getImage(bool gallery) async {
    String fs = await FilePicker.getFilePath();
    //path = fs.absolute.path;

    /*ImagePicker picker = ImagePicker();
    PickedFile pickedFile;*/
    // Let user select photo from gallery
    if (gallery) {
      path = fs;
      print(path + "==================" + "from location");
      /*pickedFile = (await picker.getImage(
        source: ImageSource.gallery,
      ))!;
      _image = pickedFile.path;
      print(File(pickedFile.path).toString());*/
    }
    // Otherwise open camera to get new photo
    else {
      /*pickedFile = (await picker.getImage(
        source: ImageSource.camera,
      ))!;*/
    }
    setState(() {
      /*if (pickedFile != null) {
        _image = pickedFile.path; // Use if you only need a single picture
      }*/
      if (fs != null) {
        path = fs;
      } else {
        print('No File selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Section"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: RawMaterialButton(
                fillColor: Theme.of(context).colorScheme.secondary,
                child: Icon(
                  Icons.add_photo_alternate_rounded,
                  color: Colors.white,
                ),
                elevation: 8,
                onPressed: () {
                  getImage(true);
                },
                padding: EdgeInsets.all(15),
                shape: const CircleBorder(),
              ),
            ),
            /*Container(
              child: Image.file(_image),
            )*/
            Container(
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                child: (const Text('Upload')),
                onPressed: () {
                  EncryptData.encrypt_file(path.toString());
                  print(_image);
                  //Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
