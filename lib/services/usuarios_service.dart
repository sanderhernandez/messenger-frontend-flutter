import 'package:chat/globals/environment.dart';
import 'package:chat/models/usuarios_response.dart';
import 'package:chat/services/services.dart';
import 'package:http/http.dart' as http;
import 'package:chat/models/models.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      Uri url = new Environment(path: 'api/usuarios').apiUrl;

      final resp = await http.get(url, headers: {
        'Content-type': 'application/json',
        'x-token': await AuthService.getToken(),
      });

      final usuariosResponse = usuariosResponseFromJson(resp.body);

      final usuarios = usuariosResponse.usuarios;

      return usuarios;
    } catch (e) {
      return [];
    }
  }
}
