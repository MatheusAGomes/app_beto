import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../shared/service/ColorSevice.dart';

class WidgetSelecionaTexto extends StatefulWidget {
  final Function()? ontap;
  String silaba;
  bool isSelected;

  WidgetSelecionaTexto({
    this.ontap,
    required this.silaba,
     required this.isSelected,
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
    await fluttertts.setVolume(1);
    await fluttertts.speak(texto);
  }
// late bool isSelected;
  @override
  void initState() {

   // isSelected = false;
    super.initState();

  }




  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
        speak(widget.silaba);
        widget.ontap!();
        setState(() {

        });
      },
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 35,
          maxWidth: 80,
        ),
          child: Center(
              child: Text(
                widget.silaba,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorService.azul,
                    fontSize: 11),
              )),

          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: widget.isSelected ? Colors.green : Color(0XFFE5E5E5),
                  width: 2,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(12))),
    );
  }
}
