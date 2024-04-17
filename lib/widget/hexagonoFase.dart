import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexagon/hexagon.dart';

class HexagonoWigetProject extends StatefulWidget {
  final Color? color;
  final String? string;

  HexagonoWigetProject({super.key, this.color, this.string});

  @override
  State<HexagonoWigetProject> createState() => _HexagonoWigetProjectState();
}

class _HexagonoWigetProjectState extends State<HexagonoWigetProject> {
  @override
  Widget build(BuildContext context) {
    return HexagonWidget.pointy(
      elevation: 10,
      width: 80,
      cornerRadius: 12,
      child: HexagonWidget.pointy(
        cornerRadius: 12,
        width: 77,
        color: widget.color,
        child: Text(
          widget.string ?? '',
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins'),
        ),
      ),
    );
  }
}
