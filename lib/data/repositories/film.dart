import 'package:rt_mobile/core/constants/others.dart';
import 'package:rt_mobile/data/models/film/film.dart';
import 'package:rt_mobile/data/services/film/film.dart';

class FilmRepository {
  final FilmService filmService;

  FilmRepository({required this.filmService});

  Future<List<Film>> getAllFilmsCurrentlyShowing() async {
    final response = await filmService.getAllFilmssCurrentlyShowing();

    if (response.isSuccess) {
      final rawData = response.data['data'];
      logger.i(rawData);
      if (rawData is List) {
        return rawData.map((film) => Film.fromJson(film)).toList();
      } else {
        throw Exception("invalid data format");
      }
    } else {
      throw Exception(
        'failed to fetch films (status code: ${response.statusCode})',
      );
    }
  }
}
