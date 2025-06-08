import 'package:rt_mobile/data/models/cinema/cinema.showtime.dart';
import 'package:rt_mobile/data/services/cinema.dart';

class CinemaRepository {
  final CinemaService cinemaService;

  CinemaRepository({required this.cinemaService});

  Future<List<CinemaShowtime>> getCinemasForShowingFilmByFilmId({
    required int filmId,
  }) async {
    final response = await cinemaService.getCinemasForShowingFilmByFilmId(
      filmId: filmId,
    );

    if (response.isSuccess) {
      final rawData = response.data['data'];

      if (rawData is List) {
        return rawData
            .map((cinema) => CinemaShowtime.fromJson(cinema))
            .toList();
      } else {
        throw Exception("invalid data format");
      }
    } else {
      throw Exception(
        'failed to fetch cinemas for showing film (status code: ${response.statusCode})',
      );
    }
  }
}
