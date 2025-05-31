part of 'bloc.dart';

sealed class MovieCarouselState extends Equatable {
  const MovieCarouselState();

  @override
  List<Object?> get props => [];
}

class MovieCarouselInitial extends MovieCarouselState {}

class MovieCarouselLoading extends MovieCarouselState {}

class MovieCarouselLoadSuccess extends MovieCarouselState {
  final List<Movie> movies;

  const MovieCarouselLoadSuccess({required this.movies}) : super();

  @override
  List<Object?> get props => [movies];
}

class MovieCarouselLoadFailed extends MovieCarouselState {
  final String message;

  const MovieCarouselLoadFailed({required this.message}) : super();

  @override
  List<Object?> get props => [message];
}
