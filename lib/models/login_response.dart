// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat/models/models.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.ok,
    required this.usuario,
    required this.token,
  });

  bool ok;
  Usuario usuario;
  String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        usuario: Usuario.fromJson(json["usuario"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": usuario.toJson(),
        "token": token,
      };
}

// class Usuario {
//   Usuario({
//     this.nombre,
//     this.email,
//     this.online,
//     this.uid,
//   });
//
//   String nombre;
//   String email;
//   String online;
//   String uid;
//
//   factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
//         nombre: json["nombre"],
//         email: json["email"],
//         online: json["online"],
//         uid: json["uid"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "nombre": nombre,
//         "email": email,
//         "online": online,
//         "uid": uid,
//       };
// }
