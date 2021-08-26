part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ListedState extends ProductState {
  final List<Product> products;

  const ListedState({required this.products});

  @override
  List<Object> get props => [products];
}

class SavedState extends ProductState {
  final Product product;

  const SavedState({required this.product});

  @override
  List<Object> get props => [product];
}

class RetrivedState extends ProductState {
  final Product product;

  const RetrivedState({required this.product});

  @override
  List<Object> get props => [product];
}

class DeletedState extends ProductState {
  final bool deleted;

  const DeletedState({required this.deleted});

  @override
  List<Object> get props => [deleted];
}

class LoadingState extends ProductState {
  LoadingState();
}

class ErrorState extends ProductState {
  final String message;
  ErrorState({required this.message});
}
