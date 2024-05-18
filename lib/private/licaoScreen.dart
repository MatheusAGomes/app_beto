import 'package:app_beto/models/licaoCompleta.dart';
import 'package:app_beto/private/fimDaLicao.dart';
import 'package:app_beto/shared/enum/tipoDaLicaoEnum.dart';
import 'package:app_beto/shared/service/ColorSevice.dart';
import 'package:flutter/material.dart';

import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../models/licao.dart';
import '../widget/opcaoTipoUmWidget.dart';

class LicaoScreen extends StatefulWidget {
  Licao licao;
  LicaoScreen({
    required this.licao,
    super.key,
  });

  @override
  State<LicaoScreen> createState() => _LicaoScreenState();
}

class _LicaoScreenState extends State<LicaoScreen> {
  late DateTime _openTime;
  late DateTime finishTime;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _openTime = DateTime.now();
    print('A tela foi aberta em: ${_openTime}');
  }

  String respostaFinal = "LAPIS";
  List<dynamic> resposta = [];
  // List<dynamic> possiveisRespostas = [
  //   {"index": "0", "silaba": "LA"},
  //   {"index": "1", "silaba": "PIS"},
  //   {"index": "2", "silaba": "CA"},
  //   {"index": "3", "silaba": "DER"},
  //   {"index": "4", "silaba": "NO"},
  //   {"index": "5", "silaba": "CU"},
  // ];
  List<dynamic> possiveisRespostas = [];

  List<Map<String, String>> convertToJsonList(List<String> lista) {
    return List<Map<String, String>>.generate(
      lista.length,
      (index) => {"index": index.toString(), "silaba": lista[index]},
    );
  }

  /// Função que procura um mapa em uma lista de mapas e retorna seu índice.
  /// Se o mapa não for encontrado, retorna -1.
  int indexOfMap(List<dynamic> list, Map<String, String> target) {
    for (int i = 0; i < list.length; i++) {
      // Compara cada mapa da lista com o mapa alvo usando a função mapEquals.
      if (mapEquals(list[i], target)) {
        return i; // Retorna o índice se encontrar o mapa.
      }
    }
    return -1; // Retorna -1 se não encontrar o mapa na lista.
  }

  /// Função que compara dois mapas para verificar se são iguais pelo conteúdo.
  /// Retorna true se os mapas forem iguais, e false caso contrário.
  bool mapEquals(Map<String, String> map1, Map<String, String> map2) {
    // Verifica se os mapas têm o mesmo número de chaves.
    if (map1.length != map2.length) {
      return false; // Retorna false se o número de chaves for diferente.
    }
    // Verifica se todos os valores correspondentes às chaves são iguais.
    for (String key in map1.keys) {
      if (map1[key] != map2[key]) {
        return false; // Retorna false se algum valor for diferente.
      }
    }
    return true; // Retorna true se todos os valores forem iguais.
  }

  String joinSilabas(List<dynamic> lista) {
    return lista.map((item) => item['silaba']).join('');
  }

  void verficandoRespostas() {
    String juncao = joinSilabas(resposta);
    print(juncao);
    print(respostaFinal);
    if (juncao == respostaFinal) {
      print('acertou');
      if (((indexExercicios) + 1) == widget.licao.exercicios.length) {
        finishTime = DateTime.now();

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => FimLicaoScreen(
                      qntEstrelas: 3,
                      tempo: finishTime.difference(_openTime),
                    )));
      } else {
        indexExercicios++;
        semaforo = false;
        resposta = [];
      }

      setState(() {});
    } else {
      print('errou');
    }
  }

  bool semaforo = false;
  int indexExercicios = 0;
  String titulo = "";

  @override
  Widget build(BuildContext context) {
    if (semaforo == false) {
      if (widget.licao.exercicios[indexExercicios].tipo ==
          TipoLicaoEnum.JuncaoDeSilabas) {
        respostaFinal =
            widget.licao.exercicios[indexExercicios].respostaEsperada;
        possiveisRespostas = convertToJsonList(
            widget.licao.exercicios[indexExercicios].possiveisSilabas!);
        titulo = widget.licao.exercicios[indexExercicios].titulo;
      }
      semaforo = true;

      setState(() {});
    }
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
            'Lição ${indexExercicios + 1}',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: LinearProgressBar(
                    minHeight: 8,
                    maxSteps: widget.licao.exercicios.length,
                    progressType: LinearProgressBar.progressTypeLinear,
                    currentStep: indexExercicios + 1,
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
                              titulo,
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
              height: 20,
            ),
            DragTarget(
              builder: (context, candidateData, rejectedData) => Container(
                  padding: EdgeInsets.only(bottom: 10),
                  width: 330,
                  height: 100,
                  color: Colors.transparent,
                  child: Wrap(
                    runAlignment: WrapAlignment.end,
                    verticalDirection: VerticalDirection.down,
                    crossAxisAlignment: WrapCrossAlignment.end,
                    spacing: 3,
                    alignment: WrapAlignment.center,
                    runSpacing: 10,
                    direction: Axis.horizontal,
                    children: List.generate(
                        resposta.length,
                        (index) => OpcaoTipoUmWidget(
                            ontap: () {
                              possiveisRespostas.add({
                                "index": "${resposta[index]['index']}",
                                "silaba": "${resposta[index]['silaba']}"
                              });
                              // int i = indexOfMap(possiveisRespostas, {
                              //   "index":
                              //       "${possiveisRespostas[index]['index']}",
                              //   "silaba":
                              //       "${possiveisRespostas[index]['index']}"
                              // });

                              resposta.removeAt(index);

                              setState(() {});
                            },
                            index: resposta[index]['index'],
                            silaba: resposta[index]['silaba'])),
                  )),
              onAcceptWithDetails: (dynamic details) {
                // print(details);
                // possiveisRespostas.removeAt(details.data as int);
                resposta.add({
                  "index": "${details.data?['index']}",
                  "silaba": "${details.data?['silaba']}"
                });
                int i = indexOfMap(possiveisRespostas, {
                  "index": "${details.data?['index']}",
                  "silaba": "${details.data?['silaba']}"
                });

                possiveisRespostas.removeAt(i);

                print(i);
                setState(() {});
              },
            ),
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.8,
              height: 2,
            ),
            const SizedBox(
              height: 46,
            ),
            DragTarget(
              onAcceptWithDetails: (dynamic details) {
                // print(details);
                // possiveisRespostas.removeAt(details.data as int);
                possiveisRespostas.add({
                  "index": "${details.data?['index']}",
                  "silaba": "${details.data?['silaba']}"
                });
                int i = indexOfMap(resposta, {
                  "index": "${details.data?['index']}",
                  "silaba": "${details.data?['silaba']}"
                });

                resposta.removeAt(i);

                print(i);
                setState(() {});
              },
              builder: (context, candidateData, rejectedData) => Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Container(
                    color: Colors.transparent,
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Wrap(
                        spacing: 3,
                        alignment: WrapAlignment.center,
                        runSpacing: 10,
                        direction: Axis.horizontal,
                        children: List.generate(
                            possiveisRespostas.length,
                            (index) => OpcaoTipoUmWidget(
                                ontap: () {
                                  resposta.add({
                                    "index":
                                        "${possiveisRespostas[index]['index']}",
                                    "silaba":
                                        "${possiveisRespostas[index]['silaba']}"
                                  });
                                  // int i = indexOfMap(possiveisRespostas, {
                                  //   "index":
                                  //       "${possiveisRespostas[index]['index']}",
                                  //   "silaba":
                                  //       "${possiveisRespostas[index]['index']}"
                                  // });

                                  possiveisRespostas.removeAt(index);

                                  setState(() {});
                                },
                                index: possiveisRespostas[index]['index'],
                                silaba: possiveisRespostas[index]['silaba'])))),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: InkWell(
                onTap: () {
                  verficandoRespostas();
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: ColorService.verde,
                      borderRadius: BorderRadius.circular(7)),
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Check',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
