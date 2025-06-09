import 'package:rt_mobile/data/models/showtime/showtime.showtime.dart';

class GroupedShowtimes {
  // key: showDate, value: [startTime, startTime, startTime]
  final Map<String, List<String>> dateToStartTimes;
  // key: aditoriumId-startTime, value: showtimeId
  final Map<String, int> startTimeToShowtimeId;

  const GroupedShowtimes({
    required this.dateToStartTimes,
    required this.startTimeToShowtimeId,
  });
}

Map<String, List<String>> groupShowtimes({
  required List<ShowtimeShowtime> showtimes,
}) {
  final Map<String, List<String>> dateToStartTimes = {};

  for (final showtime in showtimes) {
    final timeKey = "${showtime.id}-${showtime.startTime}";

    dateToStartTimes.putIfAbsent(showtime.showDate, () => []);
    dateToStartTimes[showtime.showDate]!.add(timeKey);
  }

  return dateToStartTimes;
}
