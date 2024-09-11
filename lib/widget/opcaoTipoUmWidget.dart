import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../shared/service/ColorSevice.dart';

class OpcaoTipoUmWidget extends StatefulWidget {
  VoidCallback? ontap;
  String? index;
  String silaba;

  OpcaoTipoUmWidget({
    this.index,
    this.ontap,
    required this.silaba,
    super.key,
  });

  @override
  State<OpcaoTipoUmWidget> createState() => _OpcaoTipoUmWidgetState();
}

class _OpcaoTipoUmWidgetState extends State<OpcaoTipoUmWidget> {
  final FlutterTts fluttertts = FlutterTts();
  speak(String texto) async {
    await fluttertts.setLanguage('pt-BR');
    await fluttertts.setPitch(1);
    await fluttertts.setVolume(1);

    await fluttertts.speak(texto);
  }

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      data: {"index": "${widget.index}", "silaba": "${widget.silaba}"},
      feedback: Container(
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
                  color: Color(0XFFE5E5E5), width: 2, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(12))),
      dragAnchorStrategy: childDragAnchorStrategy,
      childWhenDragging: SizedBox(),
      child: InkWell(
        onTap: () {
          speak(widget.silaba);
          widget.ontap!();
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
                    color: Color(0XFFE5E5E5),
                    width: 2,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(12))),
      ),
    );
  }
}
