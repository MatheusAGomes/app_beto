import 'package:app_beto/repository/user-repository.dart';
import 'package:app_beto/shared/service/ColorSevice.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:validatorless/validatorless.dart';

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
  GlobalKey<FormFieldState> nomeKey = GlobalKey<FormFieldState>();

  TextEditingController nomeController = TextEditingController();
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.78,
                      child: ClipRRect(
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
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 40,
                        runAlignment: WrapAlignment.center,
                        alignment: WrapAlignment.center,
                        runSpacing: 40,
                        direction: Axis.horizontal,
                        children: [
                          //testar com um List Generat
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
                          CircleAvatar(
                            radius: 72,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 70,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(120),
                                  child: Image.asset('assets/images/urso.jpg')),
                            ),
                          )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () async {
                    //to passando
                    await UserApi(dio).postLicao(widget.user);

                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Signup6Screen(
                                  user: widget.user,
                                )));
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
