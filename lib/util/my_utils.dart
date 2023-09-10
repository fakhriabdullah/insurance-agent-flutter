import 'dart:developer';

class MyUtils {
  static validatorDefault() {
    return ((value) {
      if (value!.isEmpty) {
        return "Harus diisi";
      }
      return null;
    });
  }

  static String handleErrorMessage(dynamic error) {
    log(error.toString());
    String? msg;

    try {
      msg = error.message;
    } catch (error1) {
      msg = null;
    }
    if (msg == null) {
      return "Terkadi Kesalahan";
    } else {
      return msg;
    }
  }
}
