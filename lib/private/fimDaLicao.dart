import 'package:app_beto/main.dart';
import 'package:app_beto/models/licaoCompleta.dart';
import 'package:app_beto/models/resposta.dart';
import 'package:app_beto/private/homePage.dart';
import 'package:app_beto/repository/user-repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/user.dart';
import '../shared/service/ColorSevice.dart';
import '../shared/service/stroreService.dart';

class FimLicaoScreen extends StatefulWidget {
  User user;
  int indexFilho;
  int qntEstrelas;
  String idLicao;
  Duration tempo;
  List<Resposta> resposta;
  FimLicaoScreen(
      {super.key,
      required this.user,
      required this.indexFilho,
      required this.qntEstrelas,
      required this.idLicao,
      required this.resposta,
      required this.tempo});

  @override
  State<FimLicaoScreen> createState() => _FimLicaoScreenState();
}

class _FimLicaoScreenState extends State<FimLicaoScreen> {
  String formatDuration(Duration duration) {
    // Obtém minutos e segundos do Duration
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorService.roxo,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Parabéns',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              'Você concluiu a lição',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(alignment: AlignmentDirectional.bottomCenter, children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  height: 100,
                  width: 120,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Estrelas',
                          style: TextStyle(
                              color: ColorService.roxo,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.qntEstrelas.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: ColorService.roxo,
                        borderRadius: BorderRadius.circular(15)),
                    height: 70,
                    width: 117,
                  ),
                ),
              ]),
              SizedBox(
                width: 20,
              ),
              Stack(alignment: AlignmentDirectional.bottomCenter, children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  height: 100,
                  width: 120,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tempo',
                          style: TextStyle(
                              color: ColorService.roxo,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          formatDuration(widget.tempo),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: ColorService.roxo,
                        borderRadius: BorderRadius.circular(15)),
                    height: 70,
                    width: 117,
                  ),
                ),
              ])
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
            child: InkWell(
              onTap: () async {
                //TODO DINAMIZAR ISSO AQUI
                User user = await UserApi(dio).finalizarLicao(
                    widget.user.id!,
                    widget.indexFilho.toString(),
                    LicaoCompleta(
                        idLicao: widget.idLicao,
                        respostas: widget.resposta,
                        estrelas: widget.qntEstrelas));
                await Store.save("user", user);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: ColorService.laranja,
                    borderRadius: BorderRadius.circular(15)),
                width: double.infinity,
                height: 50,
                child: Center(
                  child: Text(
                    'Voltar ao menu',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
