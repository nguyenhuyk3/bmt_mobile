import 'package:intl/intl.dart';

class ShowtimeShowtime {
  final int id;
  final int filmId;
  final int auditoriumId;
  final String showDate;
  final String startTime;
  final String endTime;
  final bool isReleased;
  final String changedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  ShowtimeShowtime({
    required this.id,
    required this.filmId,
    required this.auditoriumId,
    required this.showDate,
    required this.startTime,
    required this.endTime,
    required this.isReleased,
    required this.changedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ShowtimeShowtime.fromJson(Map<String, dynamic> json) {
    final rawStartTime = json['start_time'] as String;
    final rawEndTime = json['end_time'] as String;
    final formattedStartTime = DateFormat.Hm().format(
      DateTime.parse(rawStartTime),
    );
    final formattedEndTime = DateFormat.Hm().format(DateTime.parse(rawEndTime));

    return ShowtimeShowtime(
      id: json['id'] as int,
      filmId: json['film_id'] as int,
      auditoriumId: json['auditorium_id'] as int,
      showDate: json['show_date'] as String,
      startTime: formattedStartTime,
      endTime: formattedEndTime,
      isReleased: json['is_released'] as bool,
      changedBy: json['changed_by'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
