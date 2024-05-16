import 'package:app_beto/shared/service/ColorSevice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../widget/bannerPrincipal.dart';
import '../widget/hexagonoFase.dart';
import '../widget/opcaoTipoUmWidget.dart';
import '../widget/starMenuPrincipal.dart';

class LicaoScreen extends StatefulWidget {
  const LicaoScreen({
    super.key,
  });

  @override
  State<LicaoScreen> createState() => _LicaoScreenState();
}

class _LicaoScreenState extends State<LicaoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorService.roxo,
        leading: IconButton(
          padding: EdgeInsets.only(top: 10),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 15,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            'Lição 1',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
      ),
      backgroundColor: ColorService.roxo,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: LinearProgressBar(
                  minHeight: 8,
                  maxSteps: 9,
                  progressType: LinearProgressBar.progressTypeLinear,
                  currentStep: 4,
                  progressColor: Color(0XFF4FFFAA),
                  backgroundColor: Color(0XFF7646FE)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
                Positioned(
                  top: -30,
                  child: Column(
                    children: [
                      Container(
                        child: Center(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.14,
                          width: MediaQuery.of(context).size.height * 0.14,
                          child: Image.asset(
                            'assets/images/Pencil.png',
                          ),
                        )),
                        decoration: BoxDecoration(
                            color: ColorService.laranja,
                            borderRadius: BorderRadius.circular(12)),
                        height: MediaQuery.of(context).size.height * 0.17,
                        width: MediaQuery.of(context).size.height * 0.17,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 180,
                        width: 330,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Junte as silabas da imagem',
                            style: TextStyle(
                                color: ColorService.azul,
                                fontWeight: FontWeight.w900,
                                fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.8,
            height: 2,
          ),
          const SizedBox(
            height: 46,
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: SizedBox(
                  height: 30,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Wrap(
                    spacing: 3,
                    alignment: WrapAlignment.center,
                    runSpacing: 10,
                    direction: Axis.horizontal,
                    children: [
                      //testar com um List Generat
                      OpcaoTipoUmWidget(),
                      OpcaoTipoUmWidget(),
                      OpcaoTipoUmWidget(),
                      OpcaoTipoUmWidget(),
                      OpcaoTipoUmWidget(),
                    ],
                  )))
        ],
      ),
    );
  }
}
