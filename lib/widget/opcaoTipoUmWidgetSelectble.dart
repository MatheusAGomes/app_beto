import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../shared/service/ColorSevice.dart';

class opcaoTipoUmWidgetSelectble extends StatefulWidget {
  VoidCallback? ontap;
  String silaba;
  bool isDisable;
  Color? colorDisable;
  bool isSelected;

  opcaoTipoUmWidgetSelectble({
    this.isSelected = false,
    this.colorDisable,
    this.isDisable = false,
    this.ontap,
    required this.silaba,
    super.key,
  });

  @override
  State<opcaoTipoUmWidgetSelectble> createState() =>
      _opcaoTipoUmWidgetSelectbleState();
}

class _opcaoTipoUmWidgetSelectbleState
    extends State<opcaoTipoUmWidgetSelectble> {
  final FlutterTts fluttertts = FlutterTts();
  speak(String texto) async {
    await fluttertts.setLanguage('pt-BR');
    await fluttertts.setPitch(1);
    await fluttertts.setVolume(1);

    await fluttertts.speak(texto);
  }

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        speak(widget.silaba);
        if (widget.ontap != null) widget.ontap!();
      },
      child: Container(
          child: Center(
              child: Text(
            widget.silaba,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorService.azul,
                fontSize: 15),
          )),
          height: 35,
          width: 80,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: widget.isDisable
                      ? widget.colorDisable ?? Color(0XFFE5E5E5)
                      : widget.isDisable
                          ? ColorService.verdeClaro
                          : Color(0XFFE5E5E5),
                  width: 2,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(12))),
    );
  }
}
