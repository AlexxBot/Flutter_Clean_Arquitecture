import 'package:flutter/material.dart';

class ContainerImage extends StatelessWidget {
  final String url;
  //final double height;
  const ContainerImage({
    Key? key,
    required this.url,
    /* required this.height */
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //height: this.height,
        decoration: BoxDecoration(
      image:
          DecorationImage(image: NetworkImage(this.url), fit: BoxFit.contain),
    ));
  }
}
