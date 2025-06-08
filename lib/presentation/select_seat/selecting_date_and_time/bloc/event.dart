part of 'bloc.dart';

sealed class SelectingDateAndTimeEvent extends Equatable {
  const SelectingDateAndTimeEvent();

  @override
  List<Object?> get props => [];
}

class SelectingDateAndTimeFetched extends SelectingDateAndTimeEvent {}

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
