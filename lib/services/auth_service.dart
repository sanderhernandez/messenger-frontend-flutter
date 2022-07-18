import 'dart:convert';

import 'package:chat/globals/environment.dart';
import 'package:chat/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {
  Usuario? usuario;
  bool _autenticando = false;

  // Create storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => _autenticando;

  set autenticando(bool value) {
    _autenticando = value;
    notifyListeners();
  }

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();

    // Read value
    final String token = await _storage.read(key: 'token') ?? 'no-token';
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();

    // Delete value
    await _storage.delete(key: 'token');
  }

  /// INICIAR SESION:
  Future login(String email, String password) async {
    autenticando = true;
    final data = {
      "email": email,
      "password": password,
    };

    Uri url = new Environment(path: 'api/login').apiUrl;

    final res = await http.post(
      url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    // print('Body: ${res.body}');

    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      usuario = loginResponse.usuario;

      // TODO: Guardar token en lugar seguro.

      await _guardarToken(loginResponse.token);

      autenticando = false;

      return true;
    } else {
      autenticando = false;

      final resBody = jsonDecode(res.body);
      return resBody;
    }
  }

  /// REGISTRAR USUARIO (CREAR USUARIO):
  Future register(String nombre, String email, String password) async {
    autenticando = true;
    final data = {
      "nombre": nombre,
      "email": email,
      "password": password,
    };

    Uri url = new Environment(path: 'api/login/new').apiUrl;

    final res = await http.post(
      url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    // print('Body: ${res.body}');

    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      usuario = loginResponse.usuario;

      // TODO: Guardar token en lugar seguro.
      await _guardarToken(loginResponse.token);

      autenticando = false;

      return true;
    } else {
      autenticando = false;

      final resBody = jsonDecode(res.body);
      return resBody['msg'];
    }
  }

  Future isLoggedIn() async {
    //Obteniendo el token del Storage:
    final token = await _storage.read(key: 'token') ?? '';

    //print('token: $token');

    if (token.isNotEmpty) {
      try {
        // Renovando el token;
        Uri url = new Environment(path: 'api/login/renew').apiUrl;

        // se envia el token que tiene el cliente para ver si está valido todavia.
        final res = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'x-token': token,
          },
        );

        // print('Body: ${res.body}');

        if (res.statusCode == 200) {
          final loginResponse = loginResponseFromJson(res.body);
          usuario = loginResponse.usuario;

          // TODO: Guardar token en lugar seguro.
          await _guardarToken(loginResponse.token);

          autenticando = false;

          return true;
        } else {
          logout('token');

          autenticando = false;

          return false;
        }
      } catch (e) {
        return {
          "titulo": 'Error',
          "msg": 'Verifique su conexión a internet',
        };
      }
    } else {
      logout('token');
      print('token del storage vacio');
      return false;
    }

    // if (token.isNotEmpty) {
    //   return true;
    // } else {
    //   return false;
    // }
  }

  Future _guardarToken(String token) async {
    // Write value
    return await _storage.write(key: 'token', value: token);
  }

  Future logout(String token) async {
    // Delete value
    return await _storage.delete(key: 'token');
  }
}
