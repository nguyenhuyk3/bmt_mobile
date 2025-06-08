part of 'bloc.dart';

class SelectingDateAndTimeState extends Equatable {
  const SelectingDateAndTimeState();

  @override
  List<Object?> get props => [];
}

class SelectingDateAndTimeInitial extends SelectingDateAndTimeState {
  const SelectingDateAndTimeInitial() : super();

  @override
  List<Object?> get props => [];
}

class SelectingDateAndTimeLoading extends SelectingDateAndTimeState {
  const SelectingDateAndTimeLoading() : super();

  @override
  List<Object?> get props => [];
}

class SelectingDateAndTimeLoadSuccess extends SelectingDateAndTimeState {
  final List<Showtime> showtimes;

  const SelectingDateAndTimeLoadSuccess({required this.showtimes})
    : super();

  @override
  List<Object?> get props => [showtimes];
}

class SelectingDateAndTimeLoadFailed extends SelectingDateAndTimeState {
  final String message;

  const SelectingDateAndTimeLoadFailed({required this.message}) : super();

  @override
  List<Object?> get props => [message];
}
