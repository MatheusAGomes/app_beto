import 'package:flutter/material.dart';

import 'ColorSevice.dart';

class InputDecorationService {
  final String? dica;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  InputDecorationService({this.dica, this.prefixIcon, this.suffixIcon});

  InputDecoration get inputPadrao {
    return InputDecoration(
        filled: true,
        fillColor: Color(0XFFF5F5F5),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        hintStyle: TextStyle(color: Color(0XFFC5C5C5)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1, color: Color(0XFFC5C5C5))),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(width: 1, color: Colors.red)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(width: 1, color: Colors.red)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1, color: Color(0XFFC5C5C5))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1, color: Color(0XFFC5C5C5))),
        hintText: dica);
  }
}
