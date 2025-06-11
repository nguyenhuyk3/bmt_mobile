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

Color getPaymentMethodColor(String method) {
  switch (method) {
    case 'ZaloPay':
      return Colors.blue;
    case 'MoMo':
      return Colors.pink;
    case 'ShopeePay':
      return Colors.orange;
    case 'ATM':
      return Colors.blue[700]!;
    case 'International':
      return Colors.blue[900]!;
    default:
      return Colors.grey;
  }
}
