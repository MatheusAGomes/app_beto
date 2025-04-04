import 'package:app_beto/changeNotifier/auth.dart';
import 'package:app_beto/main.dart';
import 'package:app_beto/private/telaDeSelecaoDeFilho.dart';
import 'package:app_beto/public/signup1Screen.dart';
import 'package:app_beto/repository/licao-repository.dart';
import 'package:app_beto/repository/user-repository.dart';
import 'package:app_beto/shared/service/ColorSevice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

import '../models/user.dart';
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

  // TextEditingController usernameController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();


  TextEditingController usernameController = TextEditingController(text: 'teste@teste.com');
  TextEditingController passwordController = TextEditingController(text: '12345678');

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      backgroundColor: ColorService.roxo,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [

            Expanded(child: Image.asset('assets/images/beto.png')),
            Column(
              children: [
                TextFieldPadrao(
                  onchange: (p0) {
                    // usernameKey.currentState?.validate();
                  },
                  textFormFildKey: usernameKey,
                  validator: Validatorless.required('Campo obrigatorio'),
                  controller: usernameController,
                  errorText: 'E-mail',
                ),
                SizedBox(
                  height: 25,
                ),
                TextFieldPadrao(
                  hideTextfild: true,
                  onchange: (p0) {
                    // usernameKey.currentState?.validate();
                  },
                  textFormFildKey: passwordKey,
                  validator: Validatorless.required('Campo obrigatorio'),
                  controller: passwordController,
                  errorText: 'Senha',
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Column(
              children: [
                InkWell(
                  onTap: () async {
                    // var licoes = await LicaoApi(dio).getLicoes(false);
                    // List<User> user = await UserApi(dio).getUsers();
        
                    User user = User();
                    // pegando token
                    await auth.logar(
                        usernameController.text, passwordController.text);
        
                    user = await UserApi(dio).getUser(auth.getUserId());
        
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SelecaoDeFilhoScreen(user: user)));
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
                SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Signup1Screen()));
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
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
