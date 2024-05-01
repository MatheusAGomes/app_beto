import 'package:app_beto/public/signup1Screen.dart';
import 'package:app_beto/service/ColorSevice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:validatorless/validatorless.dart';

import '../private/homePage.dart';
import '../widget/textFieldPadrao.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  GlobalKey<FormFieldState> usernameKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> passwordKey = GlobalKey<FormFieldState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorService.roxo,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 200,
                width: 300,
                color: Colors.white,
              ),
              TextFieldPadrao(
                onchange: (p0) {
                  // usernameKey.currentState?.validate();
                },
                textFormFildKey: usernameKey,
                validator: Validatorless.required('Campo obrigatorio'),
                controller: usernameController,
                errorText: 'E-mail',
              ),
              TextFieldPadrao(
                onchange: (p0) {
                  // usernameKey.currentState?.validate();
                },
                textFormFildKey: passwordKey,
                validator: Validatorless.required('Campo obrigatorio'),
                controller: passwordController,
                errorText: 'Senha',
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
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
                      'Entrar',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signup1Screen()));
                },
                child: Container(
                  height: 46,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0XFFAA8DFF),
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(
                      'Cadastrar',
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
