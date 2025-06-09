import 'package:flutter/material.dart';

Color getSeatColor(String status) {
  switch (status) {
    case 'booked':
      return Colors.grey;
    case 'reserved':
      return Colors.grey.shade700;
    case 'available':
      return const Color(0xFF1E1E1E);
    default:
      return Colors.red;
  }
}
