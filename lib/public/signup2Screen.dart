import 'package:app_beto/public/signup3Screen.dart';
import 'package:app_beto/service/ColorSevice.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:validatorless/validatorless.dart';

import '../widget/textFieldPadrao.dart';

class Signup2Screen extends StatefulWidget {
  const Signup2Screen({super.key});

  @override
  State<Signup2Screen> createState() => _Signup2ScreenState();
}

class _Signup2ScreenState extends State<Signup2Screen> {
  GlobalKey<FormFieldState> emailKey = GlobalKey<FormFieldState>();
  TextEditingController emailController = TextEditingController();
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
                          currentStep: 4,
                          progressColor: Color(0XFF4FFFAA),
                          backgroundColor: Color(0XFF7646FE)),
                    ),
                  ),
                ],
              ),
              Text(
                'Qual seu email ?',
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
                textFormFildKey: emailKey,
                validator: Validatorless.required('Campo obrigatorio'),
                controller: emailController,
                errorText: 'E-mail',
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signup3Screen()));
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
