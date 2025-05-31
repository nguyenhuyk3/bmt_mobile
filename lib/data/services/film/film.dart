import 'package:dio/dio.dart';
import 'package:rt_mobile/data/models/api_response.dart';

class FilmService {
  final Dio dio;

  FilmService({required this.dio});

  Future<APIReponse> getAllFilmssCurrentlyShowing()async {
    final response = await dio.get('/v1/showtime/public/get_all_films_currently_showing');

    return APIReponse(statusCode: response.statusCode, data: response.data);
  }
}
