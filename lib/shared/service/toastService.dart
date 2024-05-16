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
        webBgColor: backgroundColor,
        fontSize: 16.0);
  }

  static showToastError(String msg) {
    showToast(
      msg,
      Colors.white,
      "#FF0000",
    );
  }

  static showToastInfo(String msg) {
    showToast(msg, Colors.white, "#36d75e");
  }

  static showToastWarning(String msg) {
    showToast(msg, Colors.white, "#FFFF00");
  }
}
