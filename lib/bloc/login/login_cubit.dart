import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  // UserRepository repository = UserRepositoryImpl();
  LoginCubit() : super(LoginInitial());

  void login(String username, String password) async {
    // try {
    //   var resp = await repository.login(username, password);
    //   if (resp) {
    //     emit(LoginSuccess());
    //   } else {
    //     emit(LoginError());
    //   }
    // } catch (e) {
    //   log(e.toString());
    //   emit(LoginError());
    // }
  }
}
