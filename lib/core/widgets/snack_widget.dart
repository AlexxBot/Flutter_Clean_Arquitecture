import 'package:flutter/material.dart';

class SnackWidget extends SnackBar {
  final Text content;
  final Duration duration;
  final String label;
  final Color? backgroundColor;
  const SnackWidget(this.content,
      {Key? key,
      this.duration = const Duration(seconds: 5),
      this.label = 'label',
      this.backgroundColor})
      : super(
            content: content,
            duration: duration,
            backgroundColor: backgroundColor);

  /* Widget build(BuildContext context) {
    return SnackBar(
      backgroundColor: this.backgroundColor ?? this.backgroundColor,
      content: content,
      duration: Duration(seconds: this.seconds),
      action: SnackBarAction(
        label: 'ACTION',
        onPressed: () {},
      ),
    );
  } */
}
