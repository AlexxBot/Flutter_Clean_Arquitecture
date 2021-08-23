import 'package:dartz/dartz.dart';
import 'package:sup_transp_app/core/error/failures.dart';
import 'package:sup_transp_app/features/auth/data/models/usuario.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> login(
      String codUsuario,
      String
          password); //el string que devuleve se podria considerar como el token

}
