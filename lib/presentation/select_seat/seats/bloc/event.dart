part of 'bloc.dart';

sealed class SeatsEvent extends Equatable {
  const SeatsEvent();

  @override
  List<Object?> get props => [];
}

class SeatsFetched extends SeatsEvent {}

class SeatsRefreshed extends SeatsEvent {}
