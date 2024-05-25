import 'dart:math';

import 'package:app_beto/models/licaoCompleta.dart';
import 'package:app_beto/private/licaoScreen.dart';
import 'package:app_beto/private/perfilScreen.dart';
import 'package:app_beto/repository/licao-repository.dart';
import 'package:app_beto/shared/service/ColorSevice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';
import '../models/licao.dart';
import '../models/user.dart';
import '../shared/utils.dart';
import '../widget/bannerPrincipal.dart';
import '../widget/hexagonoFase.dart';
import '../widget/starMenuPrincipal.dart';

class MyHomePage extends StatefulWidget {
  List<Licao> licoes;
  int indexDoFilho;
  User user;
  MyHomePage(
      {super.key,
      required this.licoes,
      required this.user,
      required this.indexDoFilho});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ScrollController _scrollController;

  double valor = 0.3;
  bool cordalinha = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
  }

  infiniteScrolling() {
    print(_scrollController.offset);

    if (_scrollController.offset > 70) {
      valor = (_scrollController.offset * 0.0042);
      setState(() {});
    } else {
      valor = 0.3;
      setState(() {});
    }

    if (_scrollController.offset > 240) {
      cordalinha = true;
      setState(() {});
    } else {
      cordalinha = false;
      setState(() {});
    }
  }

  LicaoCompleta? findLicaoCompleta(
      Licao licao, List<LicaoCompleta?> licoesCompletas) {
    if (licoesCompletas.length > 0)
      for (LicaoCompleta? licaoCompleta in licoesCompletas) {
        if (licaoCompleta!.numeracao == licao.numeracao) {
          return licaoCompleta;
        }
      }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    List<LicaoCompleta?> listaDelicoes =
        widget.user.filhos![widget.indexDoFilho]!.licoes;

    int estrelas =
        listaDelicoes.fold(0, (soma, item) => soma + item!.estrelas!);
    int qntEstrelas = listaDelicoes.length;
    print(estrelas);

    int proximaLicao = listaDelicoes.length + 1;

    return Scaffold(
        appBar: cordalinha
            ? AppBar(
                elevation: 0,
                leadingWidth: 60,
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 4),
                  child: CircleAvatar(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(getImageUrlFromIndexString((widget
                            .user.filhos![widget.indexDoFilho]!.foto!)))),
                  ),
                ),
                backgroundColor: ColorService.roxo,
                title: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 7),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.star,
                                  size: 12,
                                  color: ColorService.roxo,
                                ),
                              ),
                            ),
                            Text(
                              estrelas.toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 7),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.check,
                                  size: 12,
                                  color: ColorService.roxo,
                                ),
                              ),
                            ),
                            Text(
                              qntEstrelas.toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 7),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.local_fire_department,
                                  size: 12,
                                  color: ColorService.roxo,
                                ),
                              ),
                            ),
                            Text(
                              '20',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
            : null,
        backgroundColor: Color(0XFFF6F8FC),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * (valor),
              width: MediaQuery.of(context).size.width,
              color: ColorService.roxo,
            ),
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 30, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PerfilScreen()));
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CircleAvatar(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.asset(
                                          getImageUrlFromIndexString((widget
                                              .user
                                              .filhos![widget.indexDoFilho]!
                                              .foto!)))),
                                ),
                              ),
                              Text(
                                'Olá, ${widget.user.filhos![widget.indexDoFilho]!.nome!}',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                  BannerPrincipal(
                    estelas: estrelas,
                    qntConculidas: qntEstrelas,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          LicaoCompleta? licao = findLicaoCompleta(
                              widget.licoes[index], listaDelicoes ?? []);

                          return InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                if ((licao != null) ||
                                    (proximaLicao ==
                                        widget.licoes[index].numeracao))
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LicaoScreen(
                                                licao: widget.licoes[index],
                                              )));
                              },
                              child: StarMenuPrincipal(
                                proximaLicao: proximaLicao,
                                qntEstrelas: licao?.estrelas ?? 0,
                                exercicioFeito: licao != null ? true : false,
                                numeroDaLicao:
                                    widget.licoes[index].numeracao.toString(),
                              ));
                        },
                        separatorBuilder: (context, index) => Center(
                              child: Container(
                                  height: (MediaQuery.of(context).size.height *
                                      0.04),
                                  width: 2,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                          color: cordalinha
                                              ? Colors.white.withOpacity(0.5)
                                              : ColorService.roxo
                                                  .withOpacity(0.4)),
                                    ),
                                  )),
                            ),
                        itemCount: widget.licoes.length),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
