import 'package:rt_mobile/data/models/film/film.product.dart';
import 'package:rt_mobile/data/models/film/film.showtime.dart';
import 'package:rt_mobile/data/services/film.dart';

class FilmRepository {
  final FilmService filmService;

  FilmRepository({required this.filmService});

  Future<List<FilmShowtime>> getAllFilmsCurrentlyShowing() async {
    final response = await filmService.getAllFilmssCurrentlyShowing();

    if (response.isSuccess) {
      final rawData = response.data['data'];

      if (rawData is List) {
        return rawData.map((film) => FilmShowtime.fromJson(film)).toList();
      } else {
        throw Exception("invalid data format");
      }
    } else {
      throw Exception(
        'failed to fetch films (status code: ${response.statusCode})',
      );
    }
  }

  Future<FilmProduct> getFilmById({required int filmId}) async {
    final response = await filmService.getFilmById(filmId: filmId);

    if (response.isSuccess) {
      final rawData = response.data['data'];

      return FilmProduct.fromJson(rawData);
    } else {
      throw Exception(
        'failed to fetch film by id (status code: ${response.statusCode})',
      );
    }
  }
}
