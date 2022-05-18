import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Upload {
  static Future<String> upload(File file, String uid) async {
    FirebaseStorage _storage = FirebaseStorage.instance;
    String filename = file.path.split('/').last;
    print(filename + "==========================================r");
    Reference reference = _storage.ref().child(uid + "/" + filename);
    UploadTask task = reference.putFile(file);
    String FirebaseUrl = await reference.getDownloadURL();
    print(FirebaseUrl);
    return FirebaseUrl;
  }
}

class Download {}
