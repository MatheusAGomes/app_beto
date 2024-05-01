import 'package:app_beto/private/homePage.dart';
import 'package:flutter/material.dart';

import 'public/signinScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(fontFamily: 'Poppins'),
          bodyText2: TextStyle(fontFamily: 'Poppins'),
          // Adicione mais estilos de texto conforme necessário
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Brincando com beto',
      home: SigninScreen(),
    );
  }
}
