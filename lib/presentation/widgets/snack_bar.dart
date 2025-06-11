import 'package:flutter/material.dart';

void customSnackBar({
  required BuildContext context,
  required String message,
  required bool isSuccess,
}) {
  final double screenWidth = MediaQuery.of(context).size.width;

  final snackBar = SnackBar(
    // Does not take up full screen
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
    duration: const Duration(seconds: 2),
    content: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      // Adjust width
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.0001),
      decoration: BoxDecoration(
        color: isSuccess ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 16, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
