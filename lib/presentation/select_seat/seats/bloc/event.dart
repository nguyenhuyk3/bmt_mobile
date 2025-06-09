part of 'bloc.dart';

sealed class SeatsEvent extends Equatable {
  const SeatsEvent();

  @override
  List<Object?> get props => [];
}

class SeatsFetched extends SeatsEvent {}

class SeatsRefreshed extends SeatsEvent {}

class SeatsToggled extends SeatsEvent {
  final int seatId;

  const SeatsToggled(this.seatId);

  @override
  List<Object?> get props => [seatId];
}
