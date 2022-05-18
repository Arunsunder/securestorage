import 'dart:io';
import 'package:aes_crypt/aes_crypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:securestorage/Authentication/AuthenticationHelper.dart';
import 'package:securestorage/Models/UploadandDownload.dart';
import 'package:securestorage/Models/global.dart' as global;

class EncryptData {
  String fname = "";

  EncryptData() {}

  String setFilename(path) {
    String name = filename(path);
    EncryptData().fname = name;
    return name;
  }

  String filename(String path) {
    //fname=path.split('/').last;
    return path.split('/').last;
  }

  static Future<String> encrypt_file(String path) async {
    String uid = AuthenticationHelper().inputData();
    // String fileName = path.split('/').last;
    //file = fileName;
    print('Encrypt.dart--------------------- filename=====' +
        EncryptData().setFilename(path));
    print(EncryptData().fname);
    global.filename = EncryptData().setFilename(path);
    print("after......................" + global.filename);
    AesCrypt crypt = AesCrypt();
    crypt.setOverwriteMode(AesCryptOwMode.on);
    crypt.setPassword('my cool password');
    String encFilepath = "";
    String downloaurl = "";

    try {
      encFilepath = crypt.encryptFileSync(path);
      print('The encryption has been completed successfully.');
      print('Encrypted file: $encFilepath');
      print('UID:=================' + uid);
      File _file = new File(encFilepath);
      downloaurl = await Upload.upload(_file, uid);

      print(downloaurl.toString() + " ID =============================");
    } catch (e) {
      /*if (e.type == AesCryptExceptionType.destFileExists) {
        print('The encryption has been completed unsuccessfully.');
        print(e.message);
      }
      else{
        return 'ERROR';
      }*/
      print(e.toString() + "ID");
    }
    return encFilepath;
  }
}
