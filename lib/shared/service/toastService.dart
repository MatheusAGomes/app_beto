import 'package:app_beto/shared/service/ColorSevice.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastService {
  static showToast(msg, textColor, backgroundColor) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        webPosition: "right",
        backgroundColor: backgroundColor,
        fontSize: 16.0);
  }

  static showToastError(String msg) {
    showToast(
      msg,
      Colors.white,
     Colors.red,
    );
  }

  static showToastInfo(String msg) {
    showToast(msg, Colors.white, ColorService.verdeClaro);
  }

  static showToastWarning(String msg) {
    showToast(msg, Colors.white, Colors.yellow);
  }
}
