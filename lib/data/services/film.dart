import 'package:dio/dio.dart';
import 'package:rt_mobile/data/models/api_response.dart';

class FilmService {
  final Dio dio;

  FilmService({required this.dio});

  Future<APIReponse> getAllFilmssCurrentlyShowing() async {
    final response = await dio.get(
      '/showtime_service/film/public/get_all_films_currently_showing',
    );

    return APIReponse(statusCode: response.statusCode, data: response.data);
  }

  Future<APIReponse> getFilmById({required int filmId}) async {
    final response = await dio.get(
      '/product_service/film/public/get_film_by_id/$filmId',
    );

    return APIReponse(statusCode: response.statusCode, data: response.data);
  }
}
