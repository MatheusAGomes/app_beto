import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../shared/service/ColorSevice.dart';

class WidgetSelecionaTexto extends StatefulWidget {
  final Function(bool)? ontap;
  String silaba;

  WidgetSelecionaTexto({
    this.ontap,
    required this.silaba,
    super.key,
  });

  @override
  State<WidgetSelecionaTexto> createState() =>
      _WidgetSelecionaTextoState();
}

class _WidgetSelecionaTextoState
    extends State<WidgetSelecionaTexto> {
  final FlutterTts fluttertts = FlutterTts();
  speak(String texto) async {
    await fluttertts.setLanguage('pt-BR');
    await fluttertts.setPitch(1);
    await fluttertts.speak(texto);
  }
 late bool isSelected;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSelected = false;

  }




  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

        speak(widget.silaba);
        widget.ontap!(isSelected);
        setState(() {

        });
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
