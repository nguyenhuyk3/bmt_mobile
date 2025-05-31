part of 'bloc.dart';

sealed class FilmCarouselEvent extends Equatable {
  const FilmCarouselEvent();

  @override
  List<Object?> get props => [];
}

/// When the screen is opened, or the product needs to be loaded for the first time
class FilmCarouselFetched extends FilmCarouselEvent {}

/// When the user drags to refresh the list
class FilmCarouselRefreshed extends FilmCarouselEvent {}
