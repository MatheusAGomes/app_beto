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
int? numeroPar;
  opcaoTipoUmWidgetSelectble({
    this.isSelected = false,
    this.colorDisable,
    this.isDisable = false,
    this.ontap,
    required this.silaba,
    this.numeroPar,
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
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topRight,
        children: [Container(
            child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20,vertical: 5),
                  child: Text(
                                widget.silaba,
                                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorService.azul,
                    fontSize: 12),
                              ),
                )),
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
                      color:Color(0XFFE5E5E5),
                      width: 2,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(5)))],
      ),
    );
  }
}
