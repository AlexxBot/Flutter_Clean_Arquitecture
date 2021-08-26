part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

//el metodo save disparara que se guarde o se actualize segun la logica
class SaveEvent extends ProductEvent {
  final Product product;
  const SaveEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class DeleteEvent extends ProductEvent {
  final String id;
  const DeleteEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class GetEvent extends ProductEvent {
  final String id;
  const GetEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class ListEvent extends ProductEvent {
  const ListEvent();
}
