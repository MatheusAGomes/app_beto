import 'dart:math';

import 'package:flutter/material.dart';

import 'enum/tipoDaLicaoEnum.dart';
import 'enum/tipoUserEnum.dart';

String getImageUrlFromIndexString(String indexString) {
  List<String> imagens = [
    'assets/images/boiadeiro.jpg',
    'assets/images/elefante.png',
    'assets/images/guaxinim.png',
    'assets/images/porquinhoDaIndia.jpg',
    'assets/images/gato.jpg',
    'assets/images/unicornio.jpg'
  ];

  try {
    int index = int.parse(indexString);

    if (index >= 0 && index <= 5) {
      return imagens[index];
    } else {
      throw RangeError('Index out of range: $index');
    }
  } catch (e) {
    throw FormatException('Invalid input: $indexString');
  }
}

Color getRandomColor() {
  final Random random = Random();
  return Color.fromARGB(
    255, // Opacidade fixa em 255 (completamente opaco)
    random.nextInt(256), // Valor aleatório para o vermelho (0-255)
    random.nextInt(256), // Valor aleatório para o verde (0-255)
    random.nextInt(256), // Valor aleatório para o azul (0-255)
  );
}

String getTipoUser(TipoUserEnum tipoUser, BuildContext context) {
  switch (tipoUser) {
    case TipoUserEnum.Usuario:
      return "Usuario"; // Assuming String in AppLocalizations
    case TipoUserEnum.Administrador:
      return "Administrador";
    default:
      return "Tipo desconhecido";
  }
}

String formatTimeDifference(DateTime start, DateTime end) {
  Duration difference = end.difference(start);

  if (difference.inMinutes < 1) {
    return 'agora';
  } else if (difference.inMinutes >= 1 && difference.inMinutes < 60) {
    return '${difference.inMinutes} minutos';
  } else if (difference.inHours >= 1 && difference.inHours < 24) {
    return '${difference.inHours} horas';
  } else {
    return '${start.day.toString().padLeft(2, '0')}/${start.month.toString().padLeft(2, '0')}/${start.year}';
  }
}

String formatDateToBrazilTime(DateTime date) {
  // Ajuste para o horário de Brasília (UTC-3)
  DateTime brazilTime = date.toUtc().subtract(Duration(hours: 3));

  String day = brazilTime.day.toString().padLeft(2, '0');
  String month = brazilTime.month.toString().padLeft(2, '0');
  String year = brazilTime.year.toString();

  return '$day/$month/$year';
}
