import 'package:app_beto/models/licaoCompleta.dart';
import 'package:app_beto/models/objetoSelecionePares.dart';
import 'package:app_beto/models/resposta.dart';
import 'package:app_beto/private/fimDaLicao.dart';
import 'package:app_beto/shared/enum/tipoDaLicaoEnum.dart';
import 'package:app_beto/shared/service/ColorSevice.dart';
import 'package:app_beto/shared/utils.dart';
import 'package:app_beto/widget/opcaoTipoUmWidgetSelectble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../models/licao.dart';
import '../models/user.dart';
import '../shared/service/stroreService.dart';
import '../widget/WidgetSelecionePares.dart';
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
  final FlutterTts fluttertts = FlutterTts();
  speak(String texto) async {
    await fluttertts.setLanguage('pt-BR');
    await fluttertts.setPitch(1);
    await fluttertts.speak(texto);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _openTime = DateTime.now();
    initSpeech();
  }

  //funcao de comecar a ouvir
  Future<void> recognizeListen(
      SpeechRecognitionResult speachResult, SpeechToText speach) async {
    // discarta espacos reconhecidos e adicionando as respostas dadas pelo usuario
    if (speachResult.recognizedWords != "") {
      respostasDadas.add(speachResult.recognizedWords.toLowerCase());
    }
    // caso o usuario tenha acertado
    if (speachResult.recognizedWords.toLowerCase() ==
        widget.licao.exercicios[indexExercicios].respostaEsperada
            ?.toLowerCase()) {
      //para de ouvir
      speech.stop();
      //adiciona as respostas a lista de resposta dessa fase
      listaDeResposta.add(Resposta(resposta: respostasDadas));
      await finalizandoFase();
    }
    setState(() {});
  }

  String? respostaFinal = "";
  List<String> letras = [];
  List<dynamic> resposta = [];
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

  List<dynamic> respostasDadas = [];
  List<Resposta> listaDeResposta = [];

  stt.SpeechToText speech = stt.SpeechToText();

  void initSpeech() async {
    await speech.initialize(
      onError: (errorNotification) {
        setState(() {});
      },
    );
  }

  Future<void> finalizandoFase() async {
    //verificando se eh o ultimo exercicio
    if (((indexExercicios) + 1) == widget.licao.exercicios.length) {
      finishTime = DateTime.now();
      final user = User.fromJson(await Store.read("user"));
      int indexFilho = await Store.read("indexFilho");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => FimLicaoScreen(
                    idLicao: widget.licao.id!,
                    indexFilho: indexFilho,
                    resposta: listaDeResposta,
                    user: user,
                    qntEstrelas: qntEstrelasFun(
                        widget.licao.exercicios.length,
                        listaDeResposta
                            .expand((element) => element.resposta)
                            .length),
                    tempo: finishTime.difference(_openTime),
                  )));
    } else {
      //limpando os elementos da fase
      posicoesSemLetra = [];
      letrasParaExercicio = [];
      respostasDadas = [];
      indexExercicios++;
      semaforo = false;
      resposta = [];
      possiveisRespostas = [];
    }

    setState(() {});
  }

  void verficandoRespostas() async {
    String juncao = joinSilabas(resposta);
    respostasDadas.add(juncao);

    if (juncao == respostaFinal) {
      listaDeResposta.add(Resposta(resposta: respostasDadas));
      await finalizandoFase();
    }
  }

  void verficandoRespostasLicaoCompleta() async {
    String juncao = resposta.join('');
    respostasDadas.add(juncao);

    if (juncao == respostaFinal) {
      listaDeResposta.add(Resposta(resposta: respostasDadas));
      await finalizandoFase();
    }
  }

  bool arraysHaveSameContent(List<dynamic> array1, List<dynamic> array2) {
    return Set.from(array1).difference(Set.from(array2)).isEmpty &&
        Set.from(array2).difference(Set.from(array1)).isEmpty;
  }

  void verficandoRespostasSelecaoDeTexto() async {
    // onde esta a reposta do usuario
    // possiveisRespostas
    //onde esta a resposta
    //respostasEmArray
    //funcao se verifica que os dois sao validos

    respostasDadas.add(possiveisRespostas);

    if (arraysHaveSameContent(possiveisRespostas, respostasEmArray!)) {
      listaDeResposta.add(Resposta(resposta: respostasDadas));
      await finalizandoFase();
    }
  }

  int qntEstrelasFun(int qntExercicios, int qntRespostas) =>
      // caso a quantindade de exercicios dividio por resposta seja:
      // 1 = 3 estrelas
      // maior que 0.5 mas menor que 1 = 2 estrelas
      // menor que 0.5 = 1 estrela
      // qualquer erro 3 estrelas
      switch (qntExercicios / qntRespostas) {
        1 => 3,
        > 0.5 && < 1 => 2,
        <= 0.5 => 1,
        _ => 3
      };

  bool semaforo = false;
  int indexExercicios = 0;
  String titulo = "";
  List<int?>? posicoesSemLetra = [];
  List<String?>? letrasParaExercicio = [];
  List<dynamic?>? respostasEmArray = [];

  List<Widget> reproducao() {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            Positioned(
              top: -30,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (respostaFinal != null) {
                        speak(respostaFinal!);
                      }
                    },
                    child: Container(
                      child: Center(
                          child: Container(
                        height: MediaQuery.of(context).size.height * 0.14,
                        width: MediaQuery.of(context).size.height * 0.14,
                        child:
                            widget.licao.exercicios[indexExercicios].imagem !=
                                    null
                                ? Image.network(
                                    widget.licao.exercicios[indexExercicios]
                                        .imagem!,
                                  )
                                : Icon(
                                    Icons.volume_up_rounded,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                      )),
                      decoration: BoxDecoration(
                          color:
                              widget.licao.exercicios[indexExercicios].imagem !=
                                      null
                                  ? ColorService.laranja
                                  : ColorService.roxo,
                          borderRadius: BorderRadius.circular(12)),
                      height: MediaQuery.of(context).size.height * 0.17,
                      width: MediaQuery.of(context).size.height * 0.17,
                    ),
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
      SizedBox(
        height: 106,
      ),
      InkWell(
        onTap: () async {
          final options = SpeechListenOptions(
            cancelOnError: true,
          );
          //testes:
          // usuario falar a palavra certa de primeira -> ok
          // usuario falar errada -> ok mas colocar som de erro.
          // usuario nao falar nada -> ok
          if (speech.isListening == false) {
            await speech.listen(
                listenFor: const Duration(days: 1),
                onResult: (speachResult) async {
                  await recognizeListen(speachResult, speech);
                  setState(() {});
                },
                listenOptions: options);

            setState(() {});
          } else {
            speech.stop();
            setState(() {});
          }
        },
        child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: speech.isListening == false ? Color(0XFF4FFFAA) : Colors.red,
          ),
          child: Icon(
            size: 65,
            speech.isListening == false
                ? Icons.mic_none
                : Icons.pause_circle_outline,
            color: Colors.white,
          ),
        ),
      )
    ];
  }

  List<Widget> juncaoDeSilabas() {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            Positioned(
              top: -30,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (respostaFinal != null) {
                        speak(respostaFinal!);
                      }
                    },
                    child: Container(
                      child: Center(
                          child: Container(
                        height: MediaQuery.of(context).size.height * 0.14,
                        width: MediaQuery.of(context).size.height * 0.14,
                        child:
                            widget.licao.exercicios[indexExercicios].imagem !=
                                    null
                                ? Image.network(
                                    widget.licao.exercicios[indexExercicios]
                                        .imagem!,
                                  )
                                : Icon(
                                    Icons.volume_up_rounded,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                      )),
                      decoration: BoxDecoration(
                          color:
                              widget.licao.exercicios[indexExercicios].imagem !=
                                      null
                                  ? ColorService.laranja
                                  : ColorService.roxo,
                          borderRadius: BorderRadius.circular(12)),
                      height: MediaQuery.of(context).size.height * 0.17,
                      width: MediaQuery.of(context).size.height * 0.17,
                    ),
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
                              "index": "${possiveisRespostas[index]['index']}",
                              "silaba": "${possiveisRespostas[index]['silaba']}"
                            });

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
            if (resposta.isNotEmpty) {
              verficandoRespostas();
            }
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: resposta.isNotEmpty ? ColorService.verde : Colors.grey,
                borderRadius: BorderRadius.circular(7)),
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text(
                'Check',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      )
    ];
  }

  List<Widget> completePalavra() {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            Positioned(
              top: -30,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (respostaFinal != null) {
                        speak(respostaFinal!);
                      }
                    },
                    child: Container(
                      child: Center(
                          child: Container(
                        height: MediaQuery.of(context).size.height * 0.14,
                        width: MediaQuery.of(context).size.height * 0.14,
                        child:
                            widget.licao.exercicios[indexExercicios].imagem !=
                                    null
                                ? Image.network(
                                    widget.licao.exercicios[indexExercicios]
                                        .imagem!,
                                  )
                                : Icon(
                                    Icons.volume_up_rounded,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                      )),
                      decoration: BoxDecoration(
                          color:
                              widget.licao.exercicios[indexExercicios].imagem !=
                                      null
                                  ? ColorService.laranja
                                  : ColorService.roxo,
                          borderRadius: BorderRadius.circular(12)),
                      height: MediaQuery.of(context).size.height * 0.17,
                      width: MediaQuery.of(context).size.height * 0.17,
                    ),
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
                  Wrap(
                    runAlignment: WrapAlignment.end,
                    verticalDirection: VerticalDirection.down,
                    crossAxisAlignment: WrapCrossAlignment.end,
                    spacing: 3,
                    alignment: WrapAlignment.center,
                    runSpacing: 10,
                    direction: Axis.horizontal,
                    children: List.generate(letras.length, (index) {
                      if (posicoesSemLetra?.contains(index) ?? false) {
                        return DragTarget(
                          builder: (context, candidateData, rejectedData) {
                            return letras[index] == ""
                                ? Container(
                                    width: 50,
                                    height: 50,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 0),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0XFFAA8DFF)
                                                .withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 20,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(12),
                                        color: Color(0XFFAA8DFF),
                                        border: Border.all(
                                            color: Colors.white, width: 1)),
                                    child: Text(
                                      letras[index],
                                      style: TextStyle(
                                          fontSize: 35,
                                          color: Colors.transparent,
                                          fontWeight: FontWeight.bold),
                                    ))
                                : InkWell(
                                    onTap: () {
                                      letrasParaExercicio?.add(letras[index]);
                                      letras[index] = '';
                                      print(resposta);
                                      setState(() {});
                                    },
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                            width: 50,
                                            height: 50,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 2, vertical: 0),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 0),
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0XFFAA8DFF)
                                                        .withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 20,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Color(0XFFAA8DFF),
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 1)),
                                            child: Text(
                                              letras[index],
                                              style: TextStyle(
                                                  fontSize: 35,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Positioned(
                                          left: 35,
                                          top: -5,
                                          child: CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.white,
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.red,
                                              size: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          },
                          onAcceptWithDetails: (dynamic details) {
                            letras[index] = details.data?['silaba'];
                            resposta = letras;
                            int i = letrasParaExercicio!
                                .indexOf(details.data?['silaba']);
                            if (i != -1) letrasParaExercicio!.removeAt(i);
                            setState(() {});
                          },
                        );
                      }
                      return DragTarget(
                        builder: (context, candidateData, rejectedData) =>
                            Container(
                                width: 50,
                                height: 50,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0XFFAA8DFF).withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 20,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(12),
                                    color: Color(0XFFAA8DFF),
                                    border: Border.all(
                                        color: Colors.white, width: 1)),
                                child: Center(
                                  child: Text(
                                    letras[index],
                                    style: TextStyle(
                                        fontSize: 35,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                      );
                    }),
                  )
                ],
              ),
            ),
          ],
        ),
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
                      letrasParaExercicio!.length,
                      (index) => OpcaoTipoUmWidget(
                          ontap: () {
                            // resposta.add({
                            //   "index": "${possiveisRespostas[index]['index']}",
                            //   "silaba": "${possiveisRespostas[index]['silaba']}"
                            // });

                            //possiveisRespostas.removeAt(index);

                            setState(() {});
                          },
                          index: letrasParaExercicio![index],
                          silaba: letrasParaExercicio![index]!)))),
        ),
      ),
      const SizedBox(
        height: 46,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: InkWell(
          onTap: () {
            verficandoRespostasLicaoCompleta();
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: resposta.isNotEmpty ? ColorService.verde : Colors.grey,
                borderRadius: BorderRadius.circular(7)),
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text(
                'Check',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      )
    ];
  }

  List<Widget> selecioneTexto() {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            Positioned(
              top: -30,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (respostaFinal != null) {
                        speak(respostaFinal!);
                      } else {
                        speak(titulo);
                      }
                    },
                    child: Container(
                      child: Center(
                          child: Container(
                        height: MediaQuery.of(context).size.height * 0.14,
                        width: MediaQuery.of(context).size.height * 0.14,
                        child:
                            widget.licao.exercicios[indexExercicios].imagem !=
                                    null
                                ? Image.network(
                                    widget.licao.exercicios[indexExercicios]
                                        .imagem!,
                                  )
                                : Icon(
                                    Icons.volume_up_rounded,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                      )),
                      decoration: BoxDecoration(
                          color:
                              widget.licao.exercicios[indexExercicios].imagem !=
                                      null
                                  ? ColorService.laranja
                                  : ColorService.roxo,
                          borderRadius: BorderRadius.circular(12)),
                      height: MediaQuery.of(context).size.height * 0.17,
                      width: MediaQuery.of(context).size.height * 0.17,
                    ),
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
        height: 46,
      ),
      Padding(
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
                    letrasParaExercicio!.length,
                    (index) => opcaoTipoUmWidgetSelectble(
                        silaba: letrasParaExercicio![index]!)))),
      ),
      const SizedBox(
        height: 46,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: InkWell(
          onTap: () {
            if (possiveisRespostas.isNotEmpty) {
              verficandoRespostasSelecaoDeTexto();
            }
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: possiveisRespostas.isNotEmpty
                    ? ColorService.verde
                    : Colors.grey,
                borderRadius: BorderRadius.circular(7)),
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text(
                'Check',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      )
    ];
  }

  List<Widget> selecionePares() {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            Positioned(
              top: -30,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (respostaFinal != null) {
                        speak(respostaFinal!);
                      } else {
                        speak(titulo);
                      }
                    },
                    child: Container(
                      child: Center(
                          child: Container(
                        height: MediaQuery.of(context).size.height * 0.14,
                        width: MediaQuery.of(context).size.height * 0.14,
                        child: Icon(
                          Icons.compare_arrows_sharp,
                          color: Colors.white,
                          size: 50,
                        ),
                      )),
                      decoration: BoxDecoration(
                          color: ColorService.roxo,
                          borderRadius: BorderRadius.circular(12)),
                      height: MediaQuery.of(context).size.height * 0.17,
                      width: MediaQuery.of(context).size.height * 0.17,
                    ),
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
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                              objetos.length,
                              (index) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      WidgetSelecionePares(
                                        isDisable:
                                            jaFoiAcertado(index, palavra),
                                        colorDisable:
                                            jaFoiAcertado(index, palavra)
                                                ? ColorService.roxo
                                                : null,
                                        ontap: () {
                                          if ((!jaFoiAcertado(
                                              index, objetos))) {
                                            indexDasImagensSelecioandas = index;
                                            verificandoSelecionarPares();
                                            setState(() {});
                                          }
                                        },
                                        objetoSelecionePares: objetos[index],
                                        isImage: true,
                                        isSelected:
                                            (indexDasImagensSelecioandas ==
                                                index),
                                      ),
                                      opcaoTipoUmWidgetSelectble(
                                          isDisable:
                                              jaFoiAcertado(index, palavra),
                                          ontap: () {
                                            if ((!jaFoiAcertado(
                                                index, objetos))) {
                                              indexDosTextosSelecionados =
                                                  index;
                                              verificandoSelecionarPares();
                                              setState(() {});
                                            }
                                          },
                                          colorDisable:
                                              jaFoiAcertado(index, palavra)
                                                  ? ColorService.roxo
                                                  : null,
                                          isSelected:
                                              (indexDosTextosSelecionados ==
                                                  index),
                                          silaba: palavra[index])
                                    ],
                                  )),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Future<void> verificandoSelecionarPares() async {
    if (indexDasImagensSelecioandas != null &&
        indexDosTextosSelecionados != null) {
      respostasDadas.add({
        "objeto": objetos[indexDasImagensSelecioandas!],
        "palavra": palavra[indexDosTextosSelecionados!]
      });
      if (objetos[indexDasImagensSelecioandas!].nome ==
          palavra[indexDosTextosSelecionados!]) {
        acertados.add(objetos[indexDasImagensSelecioandas!].nome!);
        print('acertou');
        indexDasImagensSelecioandas = null;
        indexDosTextosSelecionados = null;
        if (acertados.length == objetos.length) {
          await finalizandoFase();
        }
      } else {
        print('errou');
        indexDasImagensSelecioandas = null;
        indexDosTextosSelecionados = null;
      }
    }
  }

  bool jaFoiAcertado(index, list) {
    bool retorno = list is List<String>
        ? acertados.contains(list[index])
        : acertados.contains(list[index].nome!);
    print(retorno);
    return retorno;
  }

  List<String> acertados = [];

// variavei selecione pares
  List<ObjetoSelecionePares> objetos = [];
  List<String> palavra = [];

  int? indexDasImagensSelecioandas;
  int? indexDosTextosSelecionados;

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
      } else if (widget.licao.exercicios[indexExercicios].tipo ==
          TipoLicaoEnum.Reproduza) {
        respostaFinal =
            widget.licao.exercicios[indexExercicios].respostaEsperada;

        titulo = widget.licao.exercicios[indexExercicios].titulo;
      } else if (widget.licao.exercicios[indexExercicios].tipo ==
          TipoLicaoEnum.CompleteAPalavra) {
        respostaFinal =
            widget.licao.exercicios[indexExercicios].respostaEsperada;
        titulo = widget.licao.exercicios[indexExercicios].titulo;
        posicoesSemLetra =
            widget.licao.exercicios[indexExercicios].posicoesSemLetra;
        letrasParaExercicio =
            widget.licao.exercicios[indexExercicios].letrasParaExercicio;
        letras = respostaFinal!.split('');
        for (var i = 0; i < letras.length; i++) {
          if (posicoesSemLetra!.contains(i)) {
            letras[i] = '';
          }
        }
      } else if (widget.licao.exercicios[indexExercicios].tipo ==
          TipoLicaoEnum.SelecioneTextos) {
        titulo = widget.licao.exercicios[indexExercicios].titulo;
        letrasParaExercicio =
            widget.licao.exercicios[indexExercicios].letrasParaExercicio;
        respostasEmArray =
            widget.licao.exercicios[indexExercicios].respostasEmArray;
      } else if (widget.licao.exercicios[indexExercicios].tipo ==
          TipoLicaoEnum.SelecionePares) {
        titulo = widget.licao.exercicios[indexExercicios].titulo;
        respostasEmArray =
            widget.licao.exercicios[indexExercicios].respostasEmArray;
        objetos = respostasEmArray!
            .map((e) => ObjetoSelecionePares(
                nome: e['nome'], urlimagem: e['urlimagem']))
            .toList();
        palavra = respostasEmArray!.map((e) => e['nome'] as String).toList();
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
            Column(
              children: switch (widget.licao.exercicios[indexExercicios].tipo) {
                TipoLicaoEnum.JuncaoDeSilabas => juncaoDeSilabas(),
                TipoLicaoEnum.Reproduza => reproducao(),
                TipoLicaoEnum.CompleteAPalavra => completePalavra(),
                TipoLicaoEnum.SelecioneTextos => selecioneTexto(),
                TipoLicaoEnum.SelecionePares => selecionePares(),
                _ => []
              },
            )
          ],
        ),
      ),
    );
  }
}
