part of 'bloc.dart';

sealed class AvailableCinemaState extends Equatable {
  const AvailableCinemaState();

  @override
  List<Object?> get props => [];
}

class AvailableCinemaInitial extends AvailableCinemaState {}

class AvailableCinemaLoading extends AvailableCinemaState {}

class AvailableCinemaLoadSuccess extends AvailableCinemaState {
  final List<CinemaShowtime> cinemas;

  const AvailableCinemaLoadSuccess({required this.cinemas}) : super();

  @override
  List<Object?> get props => [cinemas];
}

class AvailableCinemaLoadFailed extends AvailableCinemaState {
  final String message;

  const AvailableCinemaLoadFailed({required this.message}) : super();

  @override
  List<Object?> get props => [message];
}
