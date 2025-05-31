part of 'bloc.dart';

sealed class FilmState extends Equatable {
  const FilmState();

  @override
  List<Object?> get props => [];
}

class FilmInitial extends FilmState {}

class FilmLoading extends FilmState {}

class FilmLoadSuccess extends FilmState {
  final List<Film> films;

  const FilmLoadSuccess({required this.films}) : super();

  @override
  List<Object?> get props => [films];
}

class FilmLoadFailed extends FilmState {
  final String message;

  const FilmLoadFailed({required this.message}) : super();

  @override
  List<Object?> get props => [message];
}
