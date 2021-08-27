import 'package:sup_transp_app/core/error/exceptions.dart';
import 'package:sup_transp_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:sup_transp_app/core/network/network_info.dart';
import 'package:sup_transp_app/features/product/data/datasources/product_remote_data.dart';
import 'package:sup_transp_app/features/product/domain/entities/product.dart';
import 'package:sup_transp_app/features/product/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteData remoteDataSource;
  final NetworkInfo networkInfo;
  //final NetWor

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Product>>> getList() async {
    if (await networkInfo.isConnected) {
      try {
        final list = await remoteDataSource.getList();
        return Right(list);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> add(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final newProduct = await remoteDataSource.add(product);
        return Right(newProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> delete(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final eliminado = await remoteDataSource.delete(id);
        return Right(eliminado);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> get(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final product = await remoteDataSource.get(id);
        return Right(product);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> update(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final updatedProduct = await remoteDataSource.update(product);
        return Right(updatedProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
