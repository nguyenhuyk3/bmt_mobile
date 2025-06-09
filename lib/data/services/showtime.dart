import 'package:dio/dio.dart';
import 'package:rt_mobile/data/models/api_response.dart';

class ShowtimeService {
  final Dio dio;

  ShowtimeService({required this.dio});

  Future<APIReponse> getAllShowtimesByFilmIdAndByCinemaIdAndByShowDate() async {
    final response = await dio.get(
      '/showtime_service/showtime/public/get_all_showtimes_by_film_id_and_by_cinema_id_and_by_show_date',
      queryParameters: {'film_id': 1, 'cinema_id': 1},
    );

    return APIReponse(statusCode: response.statusCode, data: response.data);
  }

  Future<APIReponse> getAllShowtimeSeatsByShowtimeId() async {
    final response = await dio.get(
      '/showtime_service/showtime_seat/public/get_all_showtime_seats_by_showtime_id',
      queryParameters: {'showtime_id': 32},
    );

    return APIReponse(statusCode: response.statusCode, data: response.data);
  }
}
