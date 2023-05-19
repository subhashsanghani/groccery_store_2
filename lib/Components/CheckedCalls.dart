import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:groccery_store_2_2/Components/valueStore.dart';

class checkCall{
  final _storage = const FlutterSecureStorage();
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  Future<bool> checkLogin()async {
    var s= await ValueStore().secureReadData("isLoggedIn");
    if(s=='yes')
    {
      return true;
    }else {
      return false;
    }
  }

  Future<bool> checkSkipped()async {
    var s= await ValueStore().secureReadData("isSkipped");
    if(s=='true')
    {
      return true;
    }else {
      return false;
    }
  }

}