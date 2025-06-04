part of 'bloc.dart';

sealed class FilmInfomationEvent extends Equatable {
  const FilmInfomationEvent();

  @override
  List<Object?> get props => [];
}

// When the screen is opened, or the product needs to be loaded for the first time
class FilmInfomationFetched extends FilmInfomationEvent {
  final int filmId;

  const FilmInfomationFetched({required this.filmId}) : super();

  @override
  List<Object?> get props => [filmId];
}

// When the user drags to refresh the list
class FilmInfomationRefreshed extends FilmInfomationEvent {}
