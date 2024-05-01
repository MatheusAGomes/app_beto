import 'package:app_beto/public/signup2Screen.dart';
import 'package:app_beto/service/ColorSevice.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:validatorless/validatorless.dart';

import '../widget/textFieldPadrao.dart';

class Signup1Screen extends StatefulWidget {
  const Signup1Screen({super.key});

  @override
  State<Signup1Screen> createState() => _Signup1ScreenState();
}

class _Signup1ScreenState extends State<Signup1Screen> {
  GlobalKey<FormFieldState> nomeKey = GlobalKey<FormFieldState>();
  TextEditingController nomeController = TextEditingController();
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
                          currentStep: 2,
                          progressColor: Color(0XFF4FFFAA),
                          backgroundColor: Color(0XFF7646FE)),
                    ),
                  ),
                ],
              ),
              Text(
                'Qual seu nome ?',
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
                  // usernameKey.currentState?.validate();
                },
                textFormFildKey: nomeKey,
                validator: Validatorless.required('Campo obrigatorio'),
                controller: nomeController,
                errorText: 'Nome',
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signup2Screen()));
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
