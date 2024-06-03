import 'package:app_beto/models/user.dart';
import 'package:app_beto/private/settingScreen.dart';
import 'package:app_beto/private/telaDeSelecaoDeFilho.dart';
import 'package:app_beto/public/signinScreen.dart';
import 'package:app_beto/shared/service/ColorSevice.dart';
import 'package:app_beto/shared/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widget/bannerPrincipal.dart';
import '../widget/hexagonoFase.dart';
import '../widget/starMenuPrincipal.dart';

class PerfilScreen extends StatefulWidget {
  User user;
  int indexUsuario;
  PerfilScreen({
    required this.user,
    required this.indexUsuario,
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
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF6F8FC),
      appBar: AppBar(
        toolbarHeight: 100,
        leadingWidth: 70,
        centerTitle: true,
        backgroundColor: ColorService.roxo,
        leading: TextButton(
          onPressed: () {},
          child: Text(
            'Editar',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        title: Text(
          'Perfil',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton<String>(
            iconColor: Colors.white,
            onSelected: (String result) {
              // Ação a ser tomada quando uma opção é selecionada
              switch (result) {
                case 'Opção 1':
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelecaoDeFilhoScreen(
                              user: widget.user,
                            )),
                    (Route<dynamic> route) => false,
                  );
                  break;
                case 'Opção 2':
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SigninScreen()),
                    (Route<dynamic> route) => false,
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Opção 1',
                child: Text('Trocar usuario'),
              ),
              const PopupMenuItem<String>(
                value: 'Opção 2',
                child: Text(
                  'Sair',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            color: ColorService.roxo,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 115,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 110,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(120),
                          child: Image.asset(getImageUrlFromIndexString((widget
                              .user.filhos![widget.indexUsuario]!.foto!)))),
                    ),
                  ),
                ),
                Text(
                  widget.user.filhos![widget.indexUsuario]!.nome!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Container(
                        color: Colors.grey,
                        height: 50,
                        width: 50,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.77,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text('Licao 1'), Text('8m ago')],
                            ),
                            Text(
                                'Luca Gomes concluiu a Lição 1 no dia 30/02/2002')
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
