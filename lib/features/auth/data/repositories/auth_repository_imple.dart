import 'package:sup_transp_app/core/error/exceptions.dart';
import 'package:sup_transp_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:sup_transp_app/core/network/network_info.dart';
import 'package:sup_transp_app/features/auth/data/datasources/auth_remote_data.dart';
import 'package:sup_transp_app/features/auth/data/models/usuario.dart';
import 'package:sup_transp_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteData remoteDataSource;
  final NetworkInfo networkInfo;
  //final NetWor

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, String>> login(
      String codUsuario, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await remoteDataSource.login(codUsuario, password);
        return Right(token);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      /* try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      } */
      return Left(ServerFailure());
    }
  }
}
