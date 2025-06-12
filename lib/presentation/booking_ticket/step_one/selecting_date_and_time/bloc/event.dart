part of 'bloc.dart';

sealed class SelectingDateAndTimeEvent extends Equatable {
  const SelectingDateAndTimeEvent();

  @override
  List<Object?> get props => [];
}

class SelectingDateAndTimeFetched extends SelectingDateAndTimeEvent {
  final int filmId;
  final int cinemaId;

  const SelectingDateAndTimeFetched({this.filmId = -1, this.cinemaId = -1});

  @override
  List<Object?> get props => [filmId, cinemaId];
}

class SelectingDateAndTimeRefreshed extends SelectingDateAndTimeEvent {}

class SelectingDateAndTimeDateChanged extends SelectingDateAndTimeEvent {
  final String date;

  const SelectingDateAndTimeDateChanged({required this.date});

  @override
  List<Object?> get props => [date];
}

class SelectingDateAndTimeTimeChanged extends SelectingDateAndTimeEvent {
  final String time;

  const SelectingDateAndTimeTimeChanged({required this.time});

  @override
  List<Object?> get props => [time];
}
