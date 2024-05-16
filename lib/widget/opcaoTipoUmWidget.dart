import 'package:flutter/material.dart';

import '../shared/service/ColorSevice.dart';

class OpcaoTipoUmWidget extends StatelessWidget {
  const OpcaoTipoUmWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Text(
          "LÁ",
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
            borderRadius: BorderRadius.circular(12)));
  }
}
