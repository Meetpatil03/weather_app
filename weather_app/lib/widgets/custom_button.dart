import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final TextEditingController controller;
  final double fontSize;
  final String text;
   final VoidCallback onPressed;
  const CustomButton({super.key,required this.controller, required this.fontSize, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
     onPressed: onPressed,
    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
    child: Text(
                    text,
                    style: TextStyle(
                        fontSize: fontSize,
                        color: controller.text.isEmpty
                            ? Colors.grey
                            : Colors.purple[200]),
                  ),);
  }
}