part of 'bloc.dart';

sealed class SeatsState extends Equatable {
  const SeatsState();

  @override
  List<Object?> get props => [];
}

class SeatsInitial extends SeatsState {}

class SeatsLoading extends SeatsState {}

class SeatsLoadSuccess extends SeatsState {
  final List<SeatShowtime> seats;

  const SeatsLoadSuccess({required this.seats});

  @override
  List<Object?> get props => [seats];
}

class SeatsError extends SeatsState {
  final String message;

  const SeatsError({required this.message});

  @override
  List<Object?> get props => [message];
}
