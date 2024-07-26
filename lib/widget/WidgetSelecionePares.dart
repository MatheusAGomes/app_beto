import 'dart:ffi';

import 'package:app_beto/models/objetoSelecionePares.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../shared/service/ColorSevice.dart';

class WidgetSelecionePares extends StatefulWidget {
  VoidCallback? ontap;
  ObjetoSelecionePares objetoSelecionePares;
  bool isImage;

  WidgetSelecionePares({
    this.ontap,
    required this.objetoSelecionePares,
    this.isImage = false,
    super.key,
  });

  @override
  State<WidgetSelecionePares> createState() => _WidgetSelecioneParesState();
}

class _WidgetSelecioneParesState extends State<WidgetSelecionePares> {
  final FlutterTts fluttertts = FlutterTts();
  speak(String texto) async {
    await fluttertts.setLanguage('pt-BR');
    await fluttertts.setPitch(1);
    await fluttertts.speak(texto);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        speak(widget.objetoSelecionePares.nome ?? "");
        widget.ontap!();
      },
      child: Container(
          padding: EdgeInsets.all(10),
          child: Center(
              child:
                  Image.network(widget.objetoSelecionePares.urlimagem ?? "")),
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: Color(0XFFE5E5E5), width: 2, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(12))),
    );
  }
}
