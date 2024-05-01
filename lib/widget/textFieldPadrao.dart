import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../service/ColorSevice.dart';
import '../service/InputDecorationService.dart';

class TextFieldPadrao extends StatefulWidget {
  final GlobalKey<FormFieldState>? textFormFildKey;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardtype;
  final bool hideTextfild;
  final VoidCallback? click;
  final double fontSize;
  final TextInputAction? textInputAction;
  final Function(String?)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Function()? onEditComplete;
  final String? Function(String?)? onchange;
  final FocusNode? focusNode;
  final String? errorText;
  final dynamic padding;
  final int? maxlength;
  final bool? enable;
  List<TextInputFormatter>? inputFormatter;
  TextFieldPadrao({
    super.key,
    this.textFormFildKey,
    this.onEditComplete,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardtype = TextInputType.text,
    this.hideTextfild = false,
    this.click,
    this.fontSize = 14,
    this.validator,
    this.controller,
    this.onchange,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
    this.errorText,
    this.padding,
    this.maxlength,
    this.enable,
    this.inputFormatter,
  });

  @override
  State<TextFieldPadrao> createState() => _TextFieldPadraoState();
}

class _TextFieldPadraoState extends State<TextFieldPadrao> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: widget.onEditComplete,
      cursorColor: Color(0XFFC5C5C5),
      inputFormatters: widget.inputFormatter,
      enabled: widget.enable,
      maxLength: widget.maxlength,
      textAlignVertical: TextAlignVertical.center,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.textInputAction,
      key: widget.textFormFildKey,
      onChanged: widget.onchange,
      controller: widget.controller,
      validator: widget.validator,
      onTap: () {
        if (widget.click != null) widget.click!();
      },
      obscureText: widget.hideTextfild,
      keyboardType: widget.keyboardtype,
      style: TextStyle(fontSize: widget.fontSize),
      decoration: InputDecorationService(
              dica: widget.errorText,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon)
          .inputPadrao,
    );
  }
}
