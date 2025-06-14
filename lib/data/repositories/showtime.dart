import 'package:rt_mobile/data/models/showtime/seat.showtime.dart';
import 'package:rt_mobile/data/models/showtime/showtime.showtime.dart';
import 'package:rt_mobile/data/services/showtime.dart';

class ShowtimeRepository {
  final ShowtimeService showtimeService;

  ShowtimeRepository({required this.showtimeService});

  Future<List<ShowtimeShowtime>>
  getAllShowtimesByFilmIdAndByCinemaIdAndInDayRange({
    required int filmId,
    required int cinemaId,
  }) async {
    final response = await showtimeService
        .getAllShowtimesByFilmIdAndByCinemaIdAndInDayRange(
          filmId: filmId,
          cinemaId: cinemaId,
        );

    if (response.isSuccess) {
      final rawData = response.data['data'];

      if (rawData is List) {
        return rawData
            .map((showtime) => ShowtimeShowtime.fromJson(showtime))
            .toList();
      } else {
        throw Exception("invalid data format");
      }
    } else {
      throw Exception(
        'failed to fetch films (status code: ${response.statusCode})',
      );
    }
  }

  Future<List<SeatShowtime>> getAllShowtimeSeatsByShowtimeId({
    required int showtimeId,
  }) async {
    final response = await showtimeService.getAllShowtimeSeatsByShowtimeId(
      showtimeId: showtimeId,
    );

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

  Future<List<SeatShowtime>> getAllShowtimesSeatsByFilmIdFromEarliestTomorrow({
    required int filmId,
  }) async {
    final response = await showtimeService
        .getAllShowtimesSeatsByFilmIdFromEarliestTomorrow(filmId: filmId);

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
