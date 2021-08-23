import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sup_transp_app/core/error/exceptions.dart';
import 'package:sup_transp_app/features/auth/data/models/usuario.dart';

abstract class AuthRemoteData {
  Future<String> login(String codUsuario, String password);
}

class AuthRemoteDataImpl implements AuthRemoteData {
  late final http.Client client;

  AuthRemoteDataImpl({required this.client});

  @override
  Future<String> login(String codUsuario, String password) async {
    final uri =
        Uri.parse("https://api-rest-auth-node.herokuapp.com/auth/signin");
    final parametros = {"email": codUsuario, "password": password};
    final response = await client.post(uri,
        headers: {"content-type": "application/json"},
        body: jsonEncode(parametros));
    if (response.statusCode == 200) {
      final usuarioJson = jsonDecode(response.body);
      return usuarioJson["token"];
      //return Usuario.fromJson(usuarioJson);
    } else {
      throw ServerException();
    }
  }
}
