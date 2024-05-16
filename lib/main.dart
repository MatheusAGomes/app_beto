import 'package:app_beto/private/homePage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'public/signinScreen.dart';
import 'shared/service/ColorSevice.dart';
import 'shared/service/app.interceptor.dart';

Dio dio = Dio();
final logger = PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: true,
    error: true,
    request: true,
    compact: true,
    maxWidth: 90);

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  dio.interceptors.add(logger);
  dio.interceptors.add(AppInterceptors());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (_) {
        //ignored progress for the moment
        return Center(
          child: SpinKitPouringHourGlass(
            color: ColorService.laranja,
            size: 40.0,
          ),
        );
      },
      child: MaterialApp(
        theme: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(fontFamily: 'Poppins'),
            bodyText2: TextStyle(fontFamily: 'Poppins'),
            // Adicione mais estilos de texto conforme necessário
          ),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Brincando com beto',
        navigatorKey: navigatorKey,
        home: SigninScreen(),
      ),
    );
  }
}
