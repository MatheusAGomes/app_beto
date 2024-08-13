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
import '../shared/service/stroreService.dart';
import '../shared/utils.dart';
import '../widget/bannerPrincipal.dart';
import '../widget/hexagonoFase.dart';
import '../widget/starMenuPrincipal.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

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
  late User user;
  late int indexDoFilho;
  double valor = 0.3;
  bool cordalinha = false;
  List<Licao?> licoes = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
    _fetchLicoes();
    _fetchUser();
    _fetchIndex();
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
      int indexListaDeTodasAsLicoes, List<LicaoCompleta?> licoesCompletas) {
    if (indexListaDeTodasAsLicoes < licoesCompletas.length) {
      if (licoesCompletas[indexListaDeTodasAsLicoes] != null) {
        return licoesCompletas[indexListaDeTodasAsLicoes];
      }
    }
    return null;
  }

  // Crie um método para buscar as lições
  Future<void> _fetchLicoes() async {
    // Certifique-se de substituir `dio` pelo seu objeto Dio configurado
    var result = await LicaoApi(dio).getLicoes(false);
    setState(() {
      licoes = result;
    });
  }

  Future<void> _fetchUser() async {
    // Certifique-se de substituir `dio` pelo seu objeto Dio configurado
    final result = User.fromJson(await Store.read("user"));

    setState(() {
      user = result;
    });
  }

  Future<void> _fetchIndex() async {
    // Certifique-se de substituir `dio` pelo seu objeto Dio configurado
    final result = await Store.read("indexFilho");

    setState(() {
      indexDoFilho = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<LicaoCompleta?> listaDelicoes =
        user.filhos![indexDoFilho]!.licaoCompleta ?? [];

    int estrelas =
        listaDelicoes.fold(0, (soma, item) => soma + item!.estrelas!);
    int qntEstrelas = listaDelicoes.length;

    int qnttrofeis = listaDelicoes.fold(0,(soma,item) {
      if(item!.estrelas == 3) {
        return soma + 1;
      }
      return soma + 0 ;
    });

    int proximaLicao = listaDelicoes.length + 1;
    _fetchUser();

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
                        child: Image.asset(getImageUrlFromIndexString(
                            (user.filhos![indexDoFilho]!.foto!)))),
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
                                  Icons.emoji_events,
                                  size: 12,
                                  color: ColorService.roxo,
                                ),
                              ),
                            ),
                            Text(
                              '$qnttrofeis',
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
                                    builder: (context) => PerfilScreen(
                                          user: user,
                                          indexUsuario: indexDoFilho,
                                        )));
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CircleAvatar(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.asset(
                                          getImageUrlFromIndexString((user
                                              .filhos![indexDoFilho]!.foto!)))),
                                ),
                              ),
                              Text(
                                'Olá, ${user.filhos![indexDoFilho]!.nome!}',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  BannerPrincipal(
                    qntTrofeis: qnttrofeis,
                    estelas: estrelas,
                    qntConculidas: qntEstrelas,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          LicaoCompleta? licao =
                              findLicaoCompleta(index, listaDelicoes ?? []);

                          return InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () async {
                                if ((licao != null) ||
                                    (proximaLicao == (index + 1))) {
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LicaoScreen(
                                                licao: licoes[index]!,
                                              )));
                                  setState(() {});
                                }
                              },
                              child: StarMenuPrincipal(
                                proximaLicao: proximaLicao,
                                qntEstrelas: licao?.estrelas ?? 0,
                                exercicioFeito:
                                    licao?.estrelas != null ? true : false,
                                numeroDaLicao: (index + 1).toString(),
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
                        itemCount: licoes.length),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
