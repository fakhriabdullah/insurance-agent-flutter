import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insurance_agent_flutter/model/login/user_model.dart';

class SecureStorageUtils {
  SecureStorageUtils();
  static const String _user = "USER";
  static const String _token = "TOKEN";

  static const AndroidOptions _androidOptions =
      AndroidOptions(encryptedSharedPreferences: false);

  static Future<String> getToken() async {
    const storage = FlutterSecureStorage(aOptions: _androidOptions);
    var temp = await storage.read(key: _token);
    if (temp != null) {
      return temp;
    } else {
      log("error null token");
      return "";
    }
  }

  static void setUserData(UserModel? userData, {String? token}) async {
    if (userData == null) return;
    const storage = FlutterSecureStorage(aOptions: _androidOptions);
    await storage.write(key: _user, value: jsonEncode(userData.toJson()));
    if (token != null) await storage.write(key: _token, value: token);
  }

  static Future<UserModel?> getUserData() async {
    const storage = FlutterSecureStorage(aOptions: _androidOptions);
    var temp = await storage.read(key: _user);

    if (temp != null) {
      UserModel userData = UserModel.fromJson(jsonDecode(temp));
      return userData;
    } else {
      return null;
    }
  }

  // static void setLanguage(String language) async {
  //   const _storage = FlutterSecureStorage();
  //   await _storage.write(key: _language, value: language);
  // }

  // static Future<String?> getLanguage() async {
  //   const _storage = FlutterSecureStorage();
  //   var temp = await _storage.read(key: _language);

  //   return temp;
  // }

  static Future<void> logout() async {
    const storage = FlutterSecureStorage(aOptions: _androidOptions);
    await storage.delete(key: _token);
    await storage.delete(key: _user);
    // await storage.delete(key: _first);
  }
}
