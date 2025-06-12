part of 'bloc.dart';

sealed class SeatsEvent extends Equatable {
  const SeatsEvent();

  @override
  List<Object?> get props => [];
}

class SeatsFetched extends SeatsEvent {
  final int filmId;
  final int showtimeId;

  const SeatsFetched({this.filmId = -1, this.showtimeId = -1});

  @override
  List<Object?> get props => [showtimeId];
}

class SeatsRefreshed extends SeatsEvent {}

class SeatsToggled extends SeatsEvent {
  final int seatId;

  const SeatsToggled(this.seatId);

  @override
  List<Object?> get props => [seatId];
}

class SeatsNoShowtimeSeats extends SeatsEvent {
  final String message;

  const SeatsNoShowtimeSeats({required this.message});

  @override
  List<Object?> get props => [message];
}
