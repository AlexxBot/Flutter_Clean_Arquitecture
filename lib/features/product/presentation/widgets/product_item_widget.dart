import 'package:flutter/material.dart';
import 'package:sup_transp_app/features/product/domain/entities/product.dart';
import 'package:sup_transp_app/features/product/presentation/pages/product/product_form_page.dart';

import 'container_image_widget.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (productContext) => ProductFormPage(
                        id: this.product.id,
                      )));
        },
        child: Container(
          height: 250,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  offset: Offset(0, 5),
                  blurRadius: 10,
                  spreadRadius: 2)
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Expanded(flex: 4, child: ContainerImage(url: product.imgURL)),
              Expanded(
                  child: ListTile(
                title: Text(
                  product.name,
                  style: TextStyle(fontSize: 16),
                ),
                trailing: Text('\u0024 ${product.price}'),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
