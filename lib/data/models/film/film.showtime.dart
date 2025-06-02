class FilmShowtime {
  final int filmId;
  final String title;
  final String posterUrl;
  final String genres;
  final String duration;
  final double rating;
  final int votes;

  FilmShowtime({
    required this.filmId,
    required this.title,
    required this.posterUrl,
    required this.genres,
    required this.duration,
    required this.rating,
    required this.votes,
  });

  factory FilmShowtime.fromJson(Map<String, dynamic> json) {
    return FilmShowtime(
      filmId: json['film_id'] as int,
      posterUrl: json['poster_url'] as String,
      title: json['title'] as String,
      genres: json['genres'] as String,
      duration: json['duration'] as String,
      rating: 0,
      votes: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'film_id': filmId,
      'poster_url': posterUrl,
      'title': title,
      'genres': genres,
      'duration': duration,
      'rating': rating,
      'votes': votes,
    };
  }
}
