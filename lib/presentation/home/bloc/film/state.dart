part of 'bloc.dart';

sealed class FilmsState extends Equatable {
  const FilmsState();

  @override
  List<Object?> get props => [];
}

class FilmsInitial extends FilmsState {}

class FilmsLoading extends FilmsState {}

class FilmsLoadSuccess extends FilmsState {
  final List<FilmShowtime> films;

  const FilmsLoadSuccess({required this.films}) : super();

  @override
  List<Object?> get props => [films];
}

class FilmsLoadFailed extends FilmsState {
  final String message;

  const FilmsLoadFailed({required this.message}) : super();

  @override
  List<Object?> get props => [message];
}
