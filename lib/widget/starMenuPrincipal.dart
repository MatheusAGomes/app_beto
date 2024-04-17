import 'package:app_beto/widget/hexagonoFase.dart';
import 'package:flutter/material.dart';

import '../service/ColorSevice.dart';

class StarMenuPrincipal extends StatelessWidget {
  const StarMenuPrincipal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        HexagonoWigetProject(
          string: '1',
          color: ColorService.verde,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: 184 * 3.14,
              child: Padding(
                padding: const EdgeInsets.only(top: 70, right: 10),
                child: Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Icon(
                Icons.star,
                color: Colors.yellow,
                size: 25,
              ),
            ),
            Transform.rotate(
              angle: -184 * 3.14,
              child: Padding(
                padding: const EdgeInsets.only(top: 70, left: 10),
                child: Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 25,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
