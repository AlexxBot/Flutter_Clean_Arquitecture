import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sup_transp_app/core/error/exceptions.dart';
import 'package:sup_transp_app/core/network/headers.dart';
import 'package:sup_transp_app/core/network/network_info.dart';
import 'package:sup_transp_app/features/product/domain/entities/product.dart';
import 'package:sup_transp_app/injection_container.dart';

abstract class ProductRemoteData {
  Future<Product> add(Product product);
  Future<Product> update(Product product);
  Future<Product> get(String id);
  Future<List<Product>> getList();
  Future<bool> delete(String id);
}

class ProductRemoteDataImpl implements ProductRemoteData {
  late final http.Client client;

  ProductRemoteDataImpl({required this.client});

  @override
  Future<bool> delete(String id) async {
    final uri = Uri.parse('${sl<NetworkInfo>().url}/products/$id');
    final response = await client.delete(uri, headers: sl<Headers>().headers);
    print('entro al metodo de eliminar desde el servicio');
    if (response.statusCode == 204) {
      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> get(String id) async {
    final uri = Uri.parse('${sl<NetworkInfo>().url}/products/$id');
    final response = await client.get(uri, headers: sl<Headers>().headers);
    print('entro al metodo de recuperar desde el servicio');
    if (response.statusCode == 200) {
      final Map<String, dynamic> productJson = jsonDecode(response.body);
      final product = Product.fromJson(productJson);
      return product;
    } else {
      throw ServerException();
    }
  }

  Future<List<Product>> getList() async {
    final uri = Uri.parse('${sl<NetworkInfo>().url}/products');
    final response = await client.get(uri, headers: sl<Headers>().headers);
    print('entro al metodo de listar desde el servicio');
    if (response.statusCode == 200) {
      final listJson = jsonDecode(response.body);
      final list = listJson
          .map<Product>((product) => Product.fromJson(product))
          .toList();
      return list;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> add(Product product) async {
    final uri = Uri.parse('${sl<NetworkInfo>().url}/products');
    /* final productModel = ProductModel(
        id: product.id,
        name: product.name,
        category: product.category,
        price: product.price,
        imgURL: product.imgURL); */

    final parametros = jsonEncode(product.toJson());

    final response = await client.post(uri,
        headers: sl<Headers>().headers, body: parametros);

    if (response.statusCode == 201) {
      print('este es el body de la respuesta add product ' + response.body);
      final Map<String, dynamic> productJson = json.decode(response.body);
      final newProduct = Product.fromJson(productJson);
      return newProduct;
    } else if (response.statusCode == 403) {
      //este error es porque en los headers no se establece el token;
      throw ServerException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> update(Product product) async {
    final uri = Uri.parse('${sl<NetworkInfo>().url}/products/${product.id}');
    final parametros = jsonEncode(product.toJson());
    final response =
        await client.put(uri, headers: sl<Headers>().headers, body: parametros);

    if (response.statusCode == 200) {
      final Map<String, dynamic> productJson = jsonDecode(response.body);
      final updatedProduct = Product.fromJson(productJson);
      return updatedProduct;
    } else {
      throw ServerException();
    }
  }

  /* @override
  Future<String> login(String codUsuario, String password) async {
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
  } */
}
