import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../shared/service/ColorSevice.dart';

class opcaoTipoUmWidgetSelectble extends StatefulWidget {
  final Function(bool)? ontap;
  String silaba;

  opcaoTipoUmWidgetSelectble({
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
    await fluttertts.speak(texto);
  }

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        speak(widget.silaba);
        widget.ontap!(isSelected);
        isSelected = !isSelected;
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
                  color: isSelected ? Colors.green : Color(0XFFE5E5E5),
                  width: 2,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(12))),
    );
  }
}
