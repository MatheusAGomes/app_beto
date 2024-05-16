import 'package:app_beto/main.dart';
import 'package:app_beto/private/homePage.dart';
import 'package:app_beto/repository/licao-repository.dart';
import 'package:app_beto/shared/service/ColorSevice.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:validatorless/validatorless.dart';

import '../models/user.dart';
import '../widget/textFieldPadrao.dart';

class Signup6Screen extends StatefulWidget {
  User user;
  Signup6Screen({super.key, required this.user});

  @override
  State<Signup6Screen> createState() => _Signup6ScreenState();
}

class _Signup6ScreenState extends State<Signup6Screen> {
  GlobalKey<FormFieldState> nomeKey = GlobalKey<FormFieldState>();

  TextEditingController nomeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorService.roxo,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 220, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CircleAvatar(
                radius: 72,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 70,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: Image.asset('assets/images/urso.jpg')),
                ),
              ),
              Text(
                'Bem-vindo !',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                'O seu perfil foi criado com sucesso',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 300,
              ),
              InkWell(
                onTap: () async {
                  var licoes = await LicaoApi(dio).getLicoes(false);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(
                                licoes: licoes,
                                user: widget.user,
                              )));
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
                      'Ir ao inicio',
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
    );
  }
}
