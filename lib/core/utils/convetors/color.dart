import 'package:flutter/material.dart';

import 'package:rt_mobile/data/models/showtime/seat.showtime.dart';

Color getSeatColor(SeatShowtime seat) {
  switch (seat.status) {
    case 'reserved':
      return Colors.grey;
    case 'booked':
      return Colors.redAccent;
    default:
      return Color(0xFF1E1E1E); // available
  }
}
