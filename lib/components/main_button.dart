import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  MainButton({
    this.title,
    this.color,
    @required this.onPressed,
    this.boxDecoration,
  });

  final String title;
  final Color color;
  final Function onPressed;
  final BoxDecoration boxDecoration;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: boxDecoration,
        color: boxDecoration == null ? color : null,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
