import 'package:flutter/material.dart';
import 'package:sup_transp_app/features/product/domain/entities/product.dart';
import 'package:sup_transp_app/features/product/presentation/pages/product/product_form_page.dart';

import 'product_item_widget.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;
  const ProductList({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ProductItem(product: this.products[index]);
        },
        itemCount: products.length,
      ),
    );
  }
}
