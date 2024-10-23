import 'package:app_beto/models/filho.dart';
import 'package:app_beto/models/licaoCompleta.dart';
import 'package:app_beto/models/resposta.dart';
import 'package:app_beto/shared/service/ColorSevice.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:validatorless/validatorless.dart';

import '../models/user.dart';
import '../widget/textFieldPadrao.dart';
import 'signup5Screen.dart';

class Signup4Screen extends StatefulWidget {
  User user;
  Signup4Screen({super.key, required this.user});

  @override
  State<Signup4Screen> createState() => _Signup4ScreenState();
}

class _Signup4ScreenState extends State<Signup4Screen> {
  GlobalKey<FormFieldState> nomeKey = GlobalKey<FormFieldState>();
  TextEditingController nomeController = TextEditingController();
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorService.roxo,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    width: MediaQuery.of(context).size.width * 0.7,                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: LinearProgressBar(
                          minHeight: 8,
                          maxSteps: 5,
                          progressType: LinearProgressBar.progressTypeLinear,
                          currentStep: 4,
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
                'Digite o nome do seu filho(a)',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
              SizedBox(
                height: 10,
              ),
              TextFieldPadrao(
                onchange: (p0) {
                  nomeKey.currentState?.validate();
                },
                textFormFildKey: nomeKey,
                key: nomeKey,
                validator: Validatorless.required('Campo obrigatorio'),
                controller: nomeController,
                errorText: 'Nome',
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  if(nomeKey.currentState!.validate()){
                    User user = widget.user;
                    Filho filho = Filho(
                      licaoCompleta: [],
                      foto: "url",
                      nome: nomeController.text,
                      idDoFilho: 0,
                    );
                    user.filhos = [filho];

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Signup5Screen(
                                  user: user,
                                )));
                  }
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
    );
  }
}
