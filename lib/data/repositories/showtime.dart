import 'package:rt_mobile/core/constants/others.dart';
import 'package:rt_mobile/data/models/showtime/seat.showtime.dart';
import 'package:rt_mobile/data/models/showtime/showtime.showtime.dart';
import 'package:rt_mobile/data/services/showtime.dart';

class ShowtimeRepository {
  final ShowtimeService showtimeService;

  ShowtimeRepository({required this.showtimeService});

  Future<List<Showtime>>
  getAllShowtimesByFilmIdAndByCinemaIdAndByShowDate() async {
    final response =
        await showtimeService
            .getAllShowtimesByFilmIdAndByCinemaIdAndByShowDate();

    if (response.isSuccess) {
      final rawData = response.data['data'];

      if (rawData is List) {
        return rawData.map((showtime) => Showtime.fromJson(showtime)).toList();
      } else {
        throw Exception("invalid data format");
      }
    } else {
      throw Exception(
        'failed to fetch films (status code: ${response.statusCode})',
      );
    }
  }

  Future<List<SeatShowtime>> getAllShowtimeSeatsByShowtimeId() async {
    final response = await showtimeService.getAllShowtimeSeatsByShowtimeId();
    if (response.isSuccess) {
      final rawData = response.data['data'];

      if (rawData is List) {
        return rawData.map((seat) => SeatShowtime.fromJson(seat)).toList();
      } else {
        throw Exception("invalid data format");
      }
    } else {
      throw Exception(
        'failed to fetch seats (status code: ${response.statusCode})',
      );
    }
  }
}
