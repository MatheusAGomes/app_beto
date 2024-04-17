import 'package:app_beto/service/ColorSevice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'widget/hexagonoFase.dart';
import 'widget/starMenuPrincipal.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

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
      print("este [e] o valor ${valor}");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          onTap: () {},
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CircleAvatar(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.asset(
                                          'assets/images/urso.jpg')),
                                ),
                              ),
                              Text(
                                'Olá, Luca',
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
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    height: MediaQuery.of(context).size.height * 0.265,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 20, left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Estrelas',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: ColorService.cinza),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 7),
                                          child: CircleAvatar(
                                            radius: 14,
                                            backgroundColor: ColorService.roxo,
                                            child: Icon(
                                              Icons.star,
                                              size: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '20',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Concluídas',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: ColorService.cinza),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 7),
                                          child: CircleAvatar(
                                            radius: 14,
                                            backgroundColor: ColorService.roxo,
                                            child: Icon(
                                              Icons.check,
                                              size: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '20',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Streak',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: ColorService.cinza),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 7),
                                          child: CircleAvatar(
                                            radius: 14,
                                            backgroundColor: ColorService.roxo,
                                            child: Icon(
                                              Icons.local_fire_department,
                                              size: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '20',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Image.asset('assets/images/compartilhar.png'),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => StarMenuPrincipal(),
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
                        itemCount: 10),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
