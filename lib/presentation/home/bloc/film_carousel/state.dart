part of 'bloc.dart';

sealed class FilmCarouselState extends Equatable {
  const FilmCarouselState();

  @override
  List<Object?> get props => [];
}

class FilmCarouselInitial extends FilmCarouselState {}

class FilmCarouselLoading extends FilmCarouselState {}

class FilmCarouselLoadSuccess extends FilmCarouselState {
  final List<Film> film;

  const FilmCarouselLoadSuccess({required this.film}) : super();

  @override
  List<Object?> get props => [film];
}

class FilmCarouselLoadFailed extends FilmCarouselState {
  final String message;

  const FilmCarouselLoadFailed({required this.message}) : super();

  @override
  List<Object?> get props => [message];
}
