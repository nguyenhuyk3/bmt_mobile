part of 'bloc.dart';

sealed class FilmsEvent extends Equatable {
  const FilmsEvent();

  @override
  List<Object?> get props => [];
}

// When the screen is opened, or the product needs to be loaded for the first time
class FilmsFetched extends FilmsEvent {}

// When the user drags to refresh the list
class FilmsRefreshed extends FilmsEvent {}
