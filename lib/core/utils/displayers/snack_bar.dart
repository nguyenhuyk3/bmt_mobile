import 'package:flutter/material.dart';

void showwCustomSnackBar({
  required BuildContext context,
  required String message,
  required bool isSuccess,
}) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(
        color:
            isSuccess
                ? const Color(0xFF155724) // success text
                : const Color(0xFF721C24), // error text
      ),
    ),
    backgroundColor:
        isSuccess
            ? const Color(0xFFD4EDDA) // success background
            : const Color(0xFFF8D7DA), // error background,
    behavior: SnackBarBehavior.floating,
    elevation: 4,
    duration: const Duration(seconds: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
