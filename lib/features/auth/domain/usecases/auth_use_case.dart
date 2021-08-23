import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sup_transp_app/core/error/failures.dart';
import 'package:sup_transp_app/core/usecases/usecase.dart';
import 'package:sup_transp_app/features/auth/data/models/usuario.dart';
import 'package:sup_transp_app/features/auth/domain/repositories/auth_repository.dart';

abstract class UseCase<Type, Params> {
  //Future<Either<Failure, Type>> login(Params params);

  Future<Either<Failure, Type>> login(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthUseCase implements UseCase<String, Params> {
  AuthUseCase(this.repository);

  final AuthRepository repository;

  @override
  Future<Either<Failure, String>> login(Params params) async {
    return await repository.login(params.codUsuario, params.password);
  }
}

class Params extends Equatable {
  final String codUsuario;
  final String password;

  Params({required this.codUsuario, required this.password});

  @override
  List<Object> get props => [codUsuario, password];
}
