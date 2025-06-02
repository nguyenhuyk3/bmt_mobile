part of 'bloc.dart';

sealed class FilmInformationState extends Equatable {
  const FilmInformationState();

  @override
  List<Object?> get props => [];
}

class FilmInformationInitial extends FilmInformationState {}

class FilmInformationLoading extends FilmInformationState {}

class FilmInformationLoadSuccess extends FilmInformationState {
  final FilmProduct film;

  const FilmInformationLoadSuccess({required this.film}) : super();

  @override
  List<Object?> get props => [film];
}

class FilmInformationLoadFailed extends FilmInformationState {
  final String message;

  const FilmInformationLoadFailed({required this.message}) : super();

  @override
  List<Object?> get props => [message];
}
