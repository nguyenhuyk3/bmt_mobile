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
        return rawData
            .map((showtime) => Showtime.fromJson(showtime))
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
}
