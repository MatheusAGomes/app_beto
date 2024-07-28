import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../main.dart';
import '../repository/user-repository.dart';
import '../shared/service/stroreService.dart';

class Auth with ChangeNotifier {
  final Dio _dio;
  String? _token;
  final String _key = 'auth';
  final String fcm = 'fcm';

  Map<String, dynamic>? authDecoded;

  Auth(this._dio);

  bool get estaAutenticado {
    return token != null;
  }

  String? get token {
    if (_token != null) {
      return _token;
    } else {
      return null;
    }
  }

  Map<String, List<String>> getPermissions() {
    Map<String, dynamic> jsonData = authDecoded!['permissions'];
    Map<String, List<String>> data = {};

    jsonData.forEach((key, value) {
      if (value is List) {
        // Verifique se o valor é uma lista antes de converter para List<String>
        data[key] = List<String>.from(value.map((item) => item.toString()));
      }
    });

    return data;
  }

  String getProfileType() {
    return authDecoded!['profileType'];
  }

  String getUserId() {
    return authDecoded!['id'];
  }

  void decodificarToken(token) {
    final decodedToken = JwtDecoder.decode(token);
    authDecoded = decodedToken;
  }

  String decodificar(response) {
    final authorization = response['token'];
    print(authorization);
    String token = authorization;

    decodificarToken(token);
    return token;
  }

  Future<void> _autenticar(String username, String password) async {
    Map<String, String> userCredentials = {
      "email": username,
      "senha": password
    };
    try {
      final data = await UserApi(dio).authenticate(userCredentials);

      _token = decodificar(data);

      notifyListeners();
      Store.saveString(_key, _token!);
    } catch (e) {
      rethrow;
    }
    return Future.value();
  }

  Future<void> logar(String username, String password) async {
    return _autenticar(username, password);
  }

  void deslogar() {
    _token = null;
    Store.remove(_key);
    notifyListeners();
  }
}
