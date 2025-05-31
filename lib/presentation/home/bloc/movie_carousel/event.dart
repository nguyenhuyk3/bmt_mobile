part of 'bloc.dart';

sealed class MovieCarouselEvent extends Equatable {
  const MovieCarouselEvent();

  @override
  List<Object?> get props => [];
}

/// When the screen is opened, or the product needs to be loaded for the first time
class MovieCarouselFetched extends MovieCarouselEvent {}

/// When the user drags to refresh the list
class MovieCarouselRefreshed extends MovieCarouselEvent {}
