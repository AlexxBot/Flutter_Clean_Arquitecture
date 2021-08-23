import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;
  final double textSize;
  final GestureTapCallback onPressed;

  const ButtonWidget(
      {Key? key,
      required this.title,
      this.icon,
      this.backgroundColor = Colors.blue,
      this.textColor: Colors.white,
      this.textSize: 16,
      required this.onPressed})
      : super(key: key);

  Widget build(BuildContext context) {
    return RawMaterialButton(
        splashColor: this.backgroundColor.withOpacity(0.3),
        fillColor: this.backgroundColor,
        shape: const StadiumBorder(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: textSize * 0.5,
            horizontal: textSize,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (icon is IconData) Icon(icon, color: textColor),
              const SizedBox(
                width: 8.0,
              ),
              Text(this.title,
                  style: TextStyle(color: textColor, fontSize: textSize))
            ],
          ),
        ),
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          this.onPressed();
        });
  }
}
