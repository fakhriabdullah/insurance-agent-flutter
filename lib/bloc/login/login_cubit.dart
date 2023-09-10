import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:insurance_agent_flutter/repositories/auth_repository.dart';
import 'package:insurance_agent_flutter/util/my_utils.dart';
import 'package:insurance_agent_flutter/util/secure_storage_utils.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  AuthRepository repository = AuthRepository();
  LoginCubit() : super(LoginInitial()){
    repository.isLoggedIn().then((value) {
      if(value){
        emit(LoginSuccess());
      }
    });
  }

  void login(String username, String password) async {
    emit(LoginLoading());
    try {
      var resp = await repository.login(username, password);
      if (resp?.status ?? false) {
        SecureStorageUtils.setUserData(
          resp?.data?.user,
          token: resp?.data?.token,
        );
        emit(LoginSuccess());
      } else {
        emit(LoginError(resp?.message ?? ""));
      }
    } catch (e) {
      log(e.toString());
      emit(LoginError(MyUtils.handleErrorMessage(e)));
    }
  }
}
