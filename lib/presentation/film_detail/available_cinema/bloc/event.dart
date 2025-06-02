part of 'bloc.dart';

sealed class AvailableCinemaEvent extends Equatable {
  const AvailableCinemaEvent();

  @override
  List<Object?> get props => [];
}

class AvailableCinemaFetched extends AvailableCinemaEvent {}

class AvailableCinemaRefreshed extends AvailableCinemaEvent {}
