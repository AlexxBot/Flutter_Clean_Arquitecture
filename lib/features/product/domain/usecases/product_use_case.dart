import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sup_transp_app/core/error/failures.dart';
import 'package:sup_transp_app/core/usecases/usecase.dart';
import 'package:sup_transp_app/features/auth/data/models/usuario.dart';
import 'package:sup_transp_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:sup_transp_app/features/product/domain/entities/product.dart';
import 'package:sup_transp_app/features/product/domain/repository/product_repository.dart';

abstract class UseCase {
  //Future<Either<Failure, Type>> login(Params params);

  Future<Either<Failure, Product>> save(Product product);

  Future<Either<Failure, List<Product>>> list();

  Future<Either<Failure, Product>> get(String id);

  Future<Either<Failure, bool>> delete(String id);
}

class ProductUseCase implements UseCase {
  final ProductRepository repository;
  ProductUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> delete(String id) async {
    return await repository.delete(id);
  }

  @override
  Future<Either<Failure, Product>> get(String id) async {
    return await repository.get(id);
  }

  @override
  Future<Either<Failure, List<Product>>> list() async {
    return await repository.getList();
  }

  @override
  Future<Either<Failure, Product>> save(Product product) async {
    //aqui puedes poener toda la logica que deseas
    //este es una artificio para saber si se va a insertar o actualizar el registro
    if (product.id == '') {
      return await repository.add(product);
    } else {
      return await repository.update(product);
    }
  }

  /* @override
  Future<Either<Failure, String>> login(Params params) async {
    return await repository.login(params.codUsuario, params.password);
  } */
}

/* class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class Params extends Equatable {
  final String codUsuario;
  final String password;

  Params({required this.codUsuario, required this.password});

  @override
  List<Object> get props => [codUsuario, password];
} */
