part of 'bloc.dart';

sealed class FilmEvent extends Equatable {
  const FilmEvent();

  @override
  List<Object?> get props => [];
}

/// When the screen is opened, or the product needs to be loaded for the first time
class FilmFetched extends FilmEvent {}

/// When the user drags to refresh the list
class FilmRefreshed extends FilmEvent {}
