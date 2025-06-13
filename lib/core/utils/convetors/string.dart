import 'package:intl/intl.dart';
import 'package:rt_mobile/data/models/showtime/seat.showtime.dart';

String extractStartTime({required String input}) {
  final parts = input.split('-');

  return parts.length > 1 ? parts[1] : '';
}

String extractShowtimeId({required String input}) {
  final parts = input.split('-');

  return parts.isNotEmpty ? parts[0] : '';
}

String extractSeatNumber({required List<SeatShowtime> seats}) {
  return seats.map((seat) => seat.seatNumber).join(', ');
}

String formatCurrency(double amount) {
  final formatter = NumberFormat('#,###', 'vi_VN');
  return '${formatter.format(amount)} VND';
}
