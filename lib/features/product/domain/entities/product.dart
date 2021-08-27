import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String category;
  final double price;
  final String imgURL;

  Product(
      {this.id = '',
      this.name = '',
      this.category = '',
      this.price = 0,
      this.imgURL = ''});

  @override
  List<Object?> get props => [id, name, category, price, imgURL];

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json["_id"],
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
