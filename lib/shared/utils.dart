import 'dart:math';

import 'package:flutter/material.dart';

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
