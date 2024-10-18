import 'package:flutter/material.dart';

class AlertBox extends StatelessWidget {
  final String message;
  const AlertBox({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Something-is-Wrong",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      content:  Text(
        message,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Okay"))
      ],
    );
  }
}
