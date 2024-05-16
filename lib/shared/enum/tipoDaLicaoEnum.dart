import 'package:flutter/material.dart';

enum TipoLicaoEnum {
  JuncaoDeSilabas,
  SelecionePares,
  Reproduza,
  CompleteAPalavra,
  SelecioneImagens,
  SelecioneTextos;

  String getTipoLicaoTexto(TipoLicaoEnum tipoLicao, BuildContext context) {
    switch (tipoLicao) {
      case TipoLicaoEnum.JuncaoDeSilabas:
        return "Junção de silabas"; // Assuming String in AppLocalizations
      case TipoLicaoEnum.SelecionePares:
        return "Selecione pares";
      case TipoLicaoEnum.Reproduza:
        return "Reproduza";
      case TipoLicaoEnum.CompleteAPalavra:
        return "Complete a palavra";
      case TipoLicaoEnum.SelecioneImagens:
        return "Selecione Imagens";
      case TipoLicaoEnum.SelecioneTextos:
        return "Selecione textos";
      default:
        return "Tipo desconhecido";
    }
  }
}
