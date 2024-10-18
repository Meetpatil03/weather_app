import 'package:flutter/material.dart';

class GlowyText extends StatelessWidget {
  final double fontSize;
  final String text;
  final Color shadowColor;
  const GlowyText({super.key, required this.fontSize, required this.text, required this.shadowColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: shadowColor, blurRadius: 50, spreadRadius: 10)
        ]
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          color: Colors.white,
          
        ),
      ),
    );
  }
}
