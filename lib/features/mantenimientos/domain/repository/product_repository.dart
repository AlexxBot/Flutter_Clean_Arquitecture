import 'package:dartz/dartz.dart';
import 'package:sup_transp_app/core/error/failures.dart';
import 'package:sup_transp_app/features/auth/data/models/usuario.dart';
import 'package:sup_transp_app/features/mantenimientos/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getList();
  Future<Either<Failure, Product>> add(Product product);
  Future<Either<Failure, Product>> update(Product product);
  Future<Either<Failure, Product>> get(String id);
  Future<Either<Failure, bool>> delete(String id);
}
