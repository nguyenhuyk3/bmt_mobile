import 'package:flutter/material.dart';

void customSnackBar({
  required BuildContext context,
  required String message,
  required bool isSuccess,
}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: isSuccess ? Colors.green : Colors.red,
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
