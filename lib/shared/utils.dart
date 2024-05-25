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
