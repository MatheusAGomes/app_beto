import 'dart:ffi';

import 'package:app_beto/models/objetoSelecionePares.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../shared/service/ColorSevice.dart';

class WidgetSelecionePares extends StatefulWidget {
  VoidCallback? ontap;
  ObjetoSelecionePares objetoSelecionePares;
  bool isImage;
  bool isSelected;
  bool isDisable;
  Color? colorDisable;
  int? numeroPar;
  WidgetSelecionePares({
    this.colorDisable,
    this.isDisable = false,
    this.ontap,
    required this.objetoSelecionePares,
    this.isImage = false,
    this.isSelected = false,
    this.numeroPar,
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
    await fluttertts.setVolume(1);
    await fluttertts.speak(texto);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        speak(widget.objetoSelecionePares.nome ?? "");
        if (widget.ontap != null) widget.ontap!();
      },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        clipBehavior: Clip.none,
        children:[

          Container(
            padding: EdgeInsets.all(10),
            child: Center(
                child: widget.isImage
                    ? Image.network(widget.objetoSelecionePares.urlimagem ?? "")
                    : Text(widget.objetoSelecionePares.nome!)),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: Color(0XFFE5E5E5),
                    width: 2,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(12))),
  if(widget.numeroPar != null)        Container(
              child: Center(child: Text(widget.numeroPar.toString(),style: TextStyle(fontSize: 10,color: ColorService.azul,fontWeight: FontWeight.bold),)),
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Color(0XFFE5E5E5),
                      width: 2,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(5))),]
      ),
    );
  }
}
