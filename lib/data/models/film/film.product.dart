class FilmProduct {
  final int id;
  final String title;
  final String description;
  final String releaseDate;
  final String duration;
  final String status;
  final String posterUrl;
  final String trailerUrl;
  final List<String> genres;

  FilmProduct({
    required this.id,
    required this.title,
    required this.description,
    required this.releaseDate,
    required this.duration,
    required this.status,
    required this.posterUrl,
    required this.trailerUrl,
    required this.genres,
  });

  factory FilmProduct.fromJson(Map<String, dynamic> json) {
    final micro = json['duration']['Microseconds'] ?? 0;
    final parsedDuration = Duration(microseconds: micro);
    final hours = parsedDuration.inHours;
    final minutes = parsedDuration.inMinutes.remainder(60);
    final formattedDuration = '${hours}h${minutes}m';

    final statusText = json['status']['statuses'] ?? 'unknown';

    return FilmProduct(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      releaseDate: json['release_date'],
      duration: formattedDuration,
      status: statusText,
      posterUrl: json['poster_url'],
      trailerUrl: json['trailer_url'],
      genres: List<String>.from(json['genres']),
    );
  }
}
