import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sup_transp_app/core/error/exceptions.dart';
import 'package:sup_transp_app/core/network/headers.dart';
import 'package:sup_transp_app/core/network/network_info.dart';
import 'package:sup_transp_app/injection_container.dart';

abstract class AuthRemoteData {
  Future<String> login(String codUsuario, String password);
}

class AuthRemoteDataImpl implements AuthRemoteData {
  late final http.Client client;

  AuthRemoteDataImpl({required this.client});

  @override
  Future<String> login(String codUsuario, String password) async {
    print('${sl<NetworkInfo>().url}/auth/signin');
    final uri = Uri.parse('${sl<NetworkInfo>().url}/auth/signin');
    final parametros = {"email": codUsuario, "password": password};

    final response = await client.post(uri,
        headers: sl<Headers>().headers, body: jsonEncode(parametros));
    if (response.statusCode == 200) {
      final usuarioJson = jsonDecode(response.body);
      return usuarioJson["token"];
      //return Usuario.fromJson(usuarioJson);
    } else {
      throw ServerException();
    }
  }
}
