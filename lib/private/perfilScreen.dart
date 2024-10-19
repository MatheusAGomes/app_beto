import 'package:app_beto/models/licaoCompleta.dart';
import 'package:app_beto/models/user.dart';
import 'package:app_beto/private/editarScreen.dart';
import 'package:app_beto/private/settingScreen.dart';
import 'package:app_beto/private/telaDeSelecaoDeFilho.dart';
import 'package:app_beto/public/signinScreen.dart';
import 'package:app_beto/shared/service/ColorSevice.dart';
import 'package:app_beto/shared/utils.dart';
import 'package:app_beto/widget/hexagonoPerfil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/filho.dart';
import '../shared/service/stroreService.dart';
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

 late Filho filho ;
 List<LicaoCompleta?> licaoCompleta = [];
 @override
 void initState() {
    // TODO: implement initState

    super.initState();
 }

 void ordenarLicoes(List<LicaoCompleta?> licoes) {

   for(int i = 0; i <  licoes!.length ; i++ ){
     licoes[i]!.indexLicao = i+1;
   }

   licoes.sort((a, b) {
     if (a?.date == null && b?.date == null) {
       return 0;
     } else if (a?.date == null) {
       return 1; // Coloca as lições com data nula no final
     } else if (b?.date == null) {
       return -1; // Coloca as lições com data nula no final
     } else {
       return a!.date!.compareTo(b!.date!); // Compara datas não nulas
     }
   });
 }

  @override

  Widget build(BuildContext context) {
    filho = widget.user.filhos![widget.indexUsuario]!;
    licaoCompleta = widget.user.filhos![widget.indexUsuario]!.licaoCompleta;
   ordenarLicoes(licaoCompleta);
   licaoCompleta =   licaoCompleta.reversed.toList();
    return WillPopScope(
      onWillPop: () async {
        User usuario = widget.user;
        usuario.filhos![widget.indexUsuario] =  filho;
        await Store.save("user", usuario);

        Navigator.pop(context);

        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0XFFF6F8FC),
        appBar: AppBar(
          toolbarHeight: 100,
          leadingWidth: 70,
          centerTitle: true,
          backgroundColor: ColorService.roxo,
          leading: TextButton(
            onPressed: () async {
            await  Navigator.push(context, MaterialPageRoute(builder: (context) => EditarScreen(user: widget.user,indexUsuario: widget.indexUsuario,))).then((value) async  {
                filho= value;
                widget.user.filhos![widget.indexUsuario] = filho;
                setState(() {

                });

              });
            },
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
        body: SingleChildScrollView(
          child: Stack(
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
                              child: Image.asset(getImageUrlFromIndexString((filho.foto!)))),
                        ),
                      ),
                    ),
                    Text(
                      filho.nome!,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                    ),
                    Column(
                      children: List.generate(
                          licaoCompleta.length, (index) {
                        final licao = licaoCompleta[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HexagonoPerfil(
                                string: licao!.indexLicao.toString(),
                                color: ColorService.verde,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.77,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Lição ${licao!.indexLicao.toString()}"),
                                        Text(formatTimeDifference(
                                            licao.date!, DateTime.now()))
                                      ],
                                    ),
                                    Text(
                                        '${filho.nome} concluiu esta licão com ${licaoCompleta[index]!.estrelas} no dia ${formatDateToBrazilTime(licao.date!)}')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
