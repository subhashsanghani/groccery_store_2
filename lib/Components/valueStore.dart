

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ValueStore{


  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  final _storage = new FlutterSecureStorage();


  secureWriteData(String key , String value) async{
    await _storage.write(key: key, value: value , aOptions: _getAndroidOptions());
  }


  secureReadData(String key ) async{
  return  await _storage.read(key: key,  aOptions: _getAndroidOptions());
  }


  secureDeleteData(String key ) async{
   await _storage.delete(key: key,  aOptions: _getAndroidOptions());
  }



}