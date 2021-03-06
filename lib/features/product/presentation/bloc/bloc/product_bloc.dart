import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sup_transp_app/core/error/failures.dart';
import 'package:sup_transp_app/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:sup_transp_app/features/product/domain/entities/product.dart';
import 'package:sup_transp_app/features/product/domain/usecases/product_use_case.dart';

import 'package:http/http.dart' as http;

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductUseCase productUseCase;
  ProductBloc({required this.productUseCase}) : super(ProductInitial());

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is ListEvent) {
      yield LoadingState();
      final failureOrlisted = await productUseCase.list();
      yield* _eitherListedOrErrorState(failureOrlisted);
    }

    if (event is SaveEvent) {
      yield LoadingState();
      final failureOrSaved = await productUseCase.save(event.product);
      yield* _eitherSavedOrErrorState(failureOrSaved);
    }

    if (event is GetEvent) {
      yield LoadingState();
      final failureOrRetrived = await productUseCase.get(event.id);
      yield* _eitherRetrivedOrErrorState(failureOrRetrived);
    }

    if (event is DeleteEvent) {
      yield LoadingState();
      final failureOrDeleted = await productUseCase.delete(event.id);
      yield* _eitherDeletedOrErrorState(failureOrDeleted);
    }

    /* if (event is GetImageEvent) {
      final http.Response responseData = await http.get(Uri.parse(event.url));
      final uint8list = responseData.bodyBytes;
      var buffer = uint8list.buffer;
      ByteData byteData = ByteData.view(buffer);
      var tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/img').writeAsBytes(
          buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    } */
  }

  Stream<ProductState> _eitherListedOrErrorState(
    Either<Failure, List<Product>> failureOrlisted,
  ) async* {
    yield failureOrlisted.fold(
      (failure) => ErrorState(message: _mapFailureToMessage(failure)),
      (list) => ListedState(products: list),
    );
  }

  Stream<ProductState> _eitherDeletedOrErrorState(
    Either<Failure, bool> failureOrDeleted,
  ) async* {
    yield failureOrDeleted.fold(
      (failure) => ErrorState(message: _mapFailureToMessage(failure)),
      (deleted) => DeletedState(deleted: deleted),
    );
  }

  Stream<ProductState> _eitherRetrivedOrErrorState(
    Either<Failure, Product> failureOrRetrived,
  ) async* {
    yield failureOrRetrived.fold(
      (failure) => ErrorState(message: _mapFailureToMessage(failure)),
      (product) => RetrivedState(product: product),
    );
  }

  Stream<ProductState> _eitherSavedOrErrorState(
    Either<Failure, Product> failureOrSaved,
  ) async* {
    yield failureOrSaved.fold(
      (failure) => ErrorState(message: _mapFailureToMessage(failure)),
      (newProduct) => SavedState(product: newProduct),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_PASSWORD_MESSAGE = 'Invalid Password.';
