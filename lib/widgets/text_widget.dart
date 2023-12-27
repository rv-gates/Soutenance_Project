import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const TextWidget({Key? key, required this.text, required this.fontSize, required this.fontWeight}) : super(key: key);

  @override
  TextWidgetState createState() => TextWidgetState();
}

class TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        fontSize: widget.fontSize,
        fontWeight: widget.fontWeight,
      ),
    );
  }
}