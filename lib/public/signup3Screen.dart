import 'package:app_beto/public/signup4Screen.dart';
import 'package:app_beto/service/ColorSevice.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:validatorless/validatorless.dart';

import '../widget/textFieldPadrao.dart';

class Signup3Screen extends StatefulWidget {
  const Signup3Screen({super.key});

  @override
  State<Signup3Screen> createState() => _Signup3ScreenState();
}

class _Signup3ScreenState extends State<Signup3Screen> {
  TextEditingController senhaController = TextEditingController();
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorService.roxo,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: LinearProgressBar(
                          minHeight: 8,
                          maxSteps: 9,
                          progressType: LinearProgressBar.progressTypeLinear,
                          currentStep: 6,
                          progressColor: Color(0XFF4FFFAA),
                          backgroundColor: Color(0XFF7646FE)),
                    ),
                  ),
                ],
              ),
              Text(
                'Crie sua senha',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
              SizedBox(
                height: 10,
              ),
              TextFieldPadrao(
                controller: senhaController,
                validator: Validatorless.multiple([
                  Validatorless.required('Campo obrigatorio'),
                ]),
                hideTextfild: visible,
                hintText: 'Senha',
                suffixIcon: visible
                    ? IconButton(
                        icon: const Icon(Icons.visibility),
                        iconSize: 16,
                        color: ColorService.cinza,
                        onPressed: () {
                          setState(() {
                            visible = !visible;
                          });
                        },
                      )
                    : IconButton(
                        icon: const Icon(Icons.visibility_off),
                        color: ColorService.cinza,
                        iconSize: 16,
                        onPressed: () {
                          setState(() {
                            visible = !visible;
                          });
                        },
                      ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signup4Screen()));
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
