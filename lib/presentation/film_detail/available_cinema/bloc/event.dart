part of 'bloc.dart';

sealed class AvailableCinemaEvent extends Equatable {
  const AvailableCinemaEvent();

  @override
  List<Object?> get props => [];
}

class AvailableCinemaFetched extends AvailableCinemaEvent {
  final int filmId;

  const AvailableCinemaFetched({required this.filmId}) : super();

  @override
  List<Object?> get props => [filmId];
}

class AvailableCinemaRefreshed extends AvailableCinemaEvent {}
