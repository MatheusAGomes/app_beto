import 'package:app_beto/repository/user-repository.dart';
import 'package:app_beto/shared/enum/tipoUserEnum.dart';
import 'package:app_beto/shared/service/ColorSevice.dart';
import 'package:app_beto/shared/service/toastService.dart';
import 'package:app_beto/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

import '../changeNotifier/auth.dart';
import '../main.dart';
import '../models/user.dart';
import '../widget/textFieldPadrao.dart';
import 'signup6Screen.dart';

class Signup5Screen extends StatefulWidget {
  User user;

  Signup5Screen({super.key, required this.user});

  @override
  State<Signup5Screen> createState() => _Signup5ScreenState();
}

class _Signup5ScreenState extends State<Signup5Screen> {
  List<bool> selecionados = [false, false, false, false, false, false];
  final TextEditingController nomeController = TextEditingController();

  void selecionarImagem(int index) {
    setState(() {
      for (int i = 0; i < selecionados.length; i++) {
        selecionados[i] = i == index;
      }
    });
  }

  List<String> imagens = [
    'assets/images/boiadeiro.jpg',
    'assets/images/elefante.png',
    'assets/images/guaxinim.png',
    'assets/images/porquinhoDaIndia.jpg',
    'assets/images/gato.jpg',
    'assets/images/unicornio.jpg'
  ];

  int getSelectedIndex(List<bool> selecionados) {
    for (int i = 0; i < selecionados.length; i++) {
      if (selecionados[i]) {
        return i;
      }
    }
    return -1; // Nenhuma foto selecionada
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      backgroundColor: ColorService.roxo,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: LinearProgressBar(
                            minHeight: 8,
                            maxSteps: 5,
                            progressType: LinearProgressBar.progressTypeLinear,
                            currentStep: 5,
                            progressColor: Color(0XFF4FFFAA),
                            backgroundColor: Color(0XFF7646FE)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Selecione uma foto para o perfil',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10,
                      runAlignment: WrapAlignment.center,
                      alignment: WrapAlignment.center,
                      runSpacing: 35,
                      children: List.generate(imagens.length, (index) {
                        return InkWell(
                          onTap: () => selecionarImagem(index),
                          child: CircleAvatar(
                            radius: selecionados[index] ? 70 : 65,
                            backgroundColor: selecionados[index]
                                ? ColorService.laranja
                                : Colors.white,
                            child: CircleAvatar(
                              radius: selecionados[index] ? 68 : 62,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(120),
                                child: Image.asset(imagens[index]),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    //to passando
                    int indexDaFoto = getSelectedIndex(selecionados);
                    if (indexDaFoto == -1) {
                      ToastService.showToastError('Selecione uma imagem');
                      return;
                    }
                    User user = widget.user;
                    user.filhos![0]!.foto = indexDaFoto.toString();
                    user.tipo = getTipoUser(TipoUserEnum.Usuario, context);
                    auth.cadastrar(user);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Signup6Screen(
                                user: widget.user,
                              )),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Container(
                    height: 46,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0XFFFF9051),
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        'Continuar',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
