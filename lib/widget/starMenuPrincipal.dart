import 'package:app_beto/widget/hexagonoFase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../shared/service/ColorSevice.dart';

class StarMenuPrincipal extends StatelessWidget {
  String numeroDaLicao;
  bool exercicioFeito;
  int qntEstrelas;
  int proximaLicao;
  StarMenuPrincipal(
      {super.key,
      required this.numeroDaLicao,
      required this.exercicioFeito,
      required this.proximaLicao,
      required this.qntEstrelas});

  @override
  Widget build(BuildContext context) {
    Widget estrelas() {
      switch (qntEstrelas) {
        case 1:
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: 184 * 3.14,
                child: Padding(
                  padding: const EdgeInsets.only(top: 70, right: 10),
                  child: Icon(
                    Icons.star,
                    color: Colors.transparent,
                    size: 25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Stack(alignment: AlignmentDirectional.center, children: [
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 25,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 20,
                  ),
                ]),
              ),
              Transform.rotate(
                angle: -184 * 3.14,
                child: Padding(
                  padding: const EdgeInsets.only(top: 70, left: 10),
                  child: Icon(
                    Icons.star,
                    color: Colors.transparent,
                    size: 25,
                  ),
                ),
              )
            ],
          );

        case 2:
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: 184 * 3.14,
                child: Padding(
                  padding: const EdgeInsets.only(top: 70, right: 10),
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 25,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 20,
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Stack(alignment: AlignmentDirectional.center, children: [
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 25,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 20,
                  ),
                ]),
              ),
              Transform.rotate(
                angle: -184 * 3.14,
                child: Padding(
                  padding: const EdgeInsets.only(top: 70, left: 10),
                  child: Icon(
                    Icons.star,
                    color: Colors.transparent,
                    size: 25,
                  ),
                ),
              )
            ],
          );

        case 3:
          return Padding(
            padding: const EdgeInsets.only(top: 90),
            child: Stack(alignment: AlignmentDirectional.center, children: [
              Icon(
                Icons.emoji_events,
                color: Colors.yellow,
                size: 40,
              ),
            ]),
          );
        default:
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: 184 * 3.14,
                child: Padding(
                  padding: const EdgeInsets.only(top: 70, right: 10),
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 25,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 20,
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Stack(alignment: AlignmentDirectional.center, children: [
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 25,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 20,
                  ),
                ]),
              ),
              Transform.rotate(
                angle: -184 * 3.14,
                child: Padding(
                  padding: const EdgeInsets.only(top: 70, left: 10),
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 25,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 20,
                    ),
                  ]),
                ),
              )
            ],
          );
      }
    }

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        HexagonoWigetProject(
          string: numeroDaLicao,
          color: proximaLicao == int.parse(numeroDaLicao)
              ? Colors.yellow
              : exercicioFeito
                  ? ColorService.verde
                  : Colors.grey.withOpacity(0.4),
        ),
        exercicioFeito ? estrelas() : SizedBox()
      ],
    );
  }
}
