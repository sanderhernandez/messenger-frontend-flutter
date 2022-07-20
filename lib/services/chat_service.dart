import 'package:chat/globals/environment.dart';
import 'package:chat/models/mensajes_response.dart';
import 'package:chat/models/models.dart';
import 'package:chat/services/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  late Usuario usuarioPara;

  Future getChat(String usuarioID) async {
    Uri url = new Environment(path: 'api/mensajes/$usuarioID').apiUrl;

    final res = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken()
    });

    if (res.statusCode == 200) {
      final mensajesResponse = mensajesResponseFromJson(res.body);
      return mensajesResponse.mensajes;
    }
  }
}
