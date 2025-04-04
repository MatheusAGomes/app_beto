import 'package:app_beto/repository/user-repository.dart';
import 'package:app_beto/shared/service/ColorSevice.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:validatorless/validatorless.dart';

import '../main.dart';
import '../models/user.dart';
import '../widget/textFieldPadrao.dart';

class ImagemDePerfilScreen extends StatefulWidget {
  ImagemDePerfilScreen({
    super.key,
  });

  @override
  State<ImagemDePerfilScreen> createState() => _ImagemDePerfilScreenState();
}

class _ImagemDePerfilScreenState extends State<ImagemDePerfilScreen> {
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
                    if (indexDaFoto == -1) return;

                    Navigator.pop(context, indexDaFoto.toString());

                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Signup6Screen()));
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
                        'Selecionar',
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
