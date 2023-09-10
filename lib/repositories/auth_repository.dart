import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:insurance_agent_flutter/model/login/login_response.dart';
import 'package:insurance_agent_flutter/util/api_client.dart';
import 'package:insurance_agent_flutter/util/secure_storage_utils.dart';

class AuthRepository {
  Dio api = Client().init();
  Future<LoginResponse?> login(String username, String password) async {
    try {
      var response = await api.post("/login",
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
          ),
          data: {"username": username, "password": password});
      return LoginResponse.fromJson(jsonDecode(response.toString()));
    } on DioException catch (ex) {
      String errorMessage = jsonDecode(ex.response.toString())["message"];
      throw Exception(errorMessage);
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      String token = await SecureStorageUtils.getToken();
      return token.isNotEmpty;
    }  catch (ex) {
      return false;
    }
  }
}
