import 'package:sup_transp_app/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel(
      {required String id,
      required String name,
      required String category,
      required double price,
      required String imgURL})
      : super(
            id: id,
            name: name,
            category: category,
            price: price,
            imgURL: imgURL);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['_id'],
        name: json["name"],
        category: json["category"],
        price: (json['price'] as num).toDouble(),
        imgURL: json["imgURL"]);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'category': category,
      'price': price,
      'imgURL': imgURL
    };
  }
}
