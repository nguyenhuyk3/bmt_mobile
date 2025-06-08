import 'package:rt_mobile/data/models/showtime/showtime.showtime.dart';

Map<String, List<String>> groupShowtimesByDate(List<Showtime> showtimes) {
  final Map<String, List<String>> grouped = {};

  for (final showtime in showtimes) {
    if (!grouped.containsKey(showtime.showDate)) {
      grouped[showtime.showDate] = [];
    }

    grouped[showtime.showDate]!.add(showtime.startTime);
  }

  return grouped;
}
