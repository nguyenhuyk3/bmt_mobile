import 'package:dio/dio.dart';
import 'package:rt_mobile/data/models/api_response.dart';

class ShowtimeService {
  final Dio dio;

  ShowtimeService({required this.dio});

  Future<APIReponse> getAllShowtimesByFilmIdAndByCinemaIdAndInDayRange({
    required int filmId,
    required int cinemaId,
  }) async {
    final response = await dio.get(
      '/showtime_service/showtime/public/get_all_showtimes_by_film_id_and_by_cinema_id_and_in_day_range',
      queryParameters: {'film_id': filmId, 'cinema_id': cinemaId},
    );

    return APIReponse(statusCode: response.statusCode, data: response.data);
  }

  Future<APIReponse> getAllShowtimeSeatsByShowtimeId({
    required int showtimeId,
  }) async {
    final response = await dio.get(
      '/showtime_service/showtime_seat/public/get_all_showtime_seats_by_showtime_id',
      queryParameters: {'showtime_id': showtimeId},
    );

    return APIReponse(statusCode: response.statusCode, data: response.data);
  }

  Future<APIReponse> getAllShowtimesSeatsByFilmIdFromEarliestTomorrow({
    required int filmId,
  }) async {
    final response = await dio.get(
      '/showtime_service/showtime_seats/public/get_all_showtime_seats_by_film_id_from_earliest_tomorrow',
      queryParameters: {'film_id': filmId},
    );

    return APIReponse(statusCode: response.statusCode, data: response.data);
  }
}
