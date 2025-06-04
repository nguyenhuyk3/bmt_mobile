import 'package:dio/dio.dart';
import 'package:rt_mobile/core/constants/others.dart';
import 'package:rt_mobile/data/models/api_response.dart';

class CinemaService {
  final Dio dio;

  CinemaService({required this.dio});

  Future<APIReponse> getCinemasForShowingFilmByFilmId() async {
    final response = await dio.get(
      '/showtime_service/cinema/get_cinemas_for_showing_film_by_film_id/1',
    );

    logger.i(response.statusCode);

    return APIReponse(statusCode: response.statusCode, data: response.data);
  }
}
