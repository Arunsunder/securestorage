import 'dart:io';
import 'package:aes_crypt/aes_crypt.dart';

class DecryptData {
  static Future<String> decrypt_file(String path) async {
    AesCrypt crypt = AesCrypt();
    crypt.setOverwriteMode(AesCryptOwMode.on);
    crypt.setPassword('my cool password');
    String decFilepath = "";
    try {
      decFilepath = crypt.decryptFileSync(path);
      print('The decryption has been completed successfully.');
      print('Decrypted file 1: $decFilepath');
      print('File content: ' + File(decFilepath).path);
    } catch (e) {
      /*if (e.type == AesCryptExceptionType.destFileExists) {
        print('The decryption has been completed unsuccessfully.');
        print(e.message);
      }
      else{
        return 'ERROR';
      }*/
      print(e);
    }
    return decFilepath;
  }
}
