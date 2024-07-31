import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexagon/hexagon.dart';

class HexagonoPerfil extends StatefulWidget {
  final Color? color;
  final String? string;

  HexagonoPerfil({super.key, this.color, this.string});

  @override
  State<HexagonoPerfil> createState() => _HexagonoWigetProjectState();
}

class _HexagonoWigetProjectState extends State<HexagonoPerfil> {
  @override
  Widget build(BuildContext context) {
    return HexagonWidget.pointy(
      elevation: 10,
      width: 45,
      cornerRadius: 5,
      child: HexagonWidget.pointy(
        cornerRadius: 5,
        width: 42,
        color: widget.color,
        child: Text(
          widget.string ?? '',
          style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins'),
        ),
      ),
    );
  }
}
