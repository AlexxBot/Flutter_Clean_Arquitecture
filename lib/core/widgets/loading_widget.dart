import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget({Key? key}) : super(key: key);

  static void show(BuildContext context, {Key? key}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => LoadingWidget(key: key),
    );
  }

  static void hide(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            //decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/Logo B&S 3D.jpg'),fit: BoxFit.cover)),
            width: 70,
            height: 70,
            padding: EdgeInsets.all(15.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
