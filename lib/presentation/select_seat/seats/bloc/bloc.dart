import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/core/constants/others.dart';
import 'package:rt_mobile/data/models/showtime/seat.showtime.dart';

import 'package:rt_mobile/data/repositories/showtime.dart';

part 'event.dart';
part 'state.dart';

class SeatsBloc extends Bloc<SeatsEvent, SeatsState> {
  final ShowtimeRepository showtimeRepository;

  SeatsBloc({required this.showtimeRepository}) : super(SeatsInitial()) {
    on<SeatsFetched>(_onSeatsFetched);
    on<SeatsRefreshed>(_onSeatsRefreshed);
  }

  FutureOr<void> _onSeatsFetched(
    SeatsFetched event,
    Emitter<SeatsState> emit,
  ) async {
    emit(SeatsLoading());

    try {
      final seats = await showtimeRepository.getAllShowtimeSeatsByShowtimeId();

      logger.i(state);

      emit(SeatsLoadSuccess(seats: seats));
    } catch (e) {
      emit(SeatsError(message: e.toString()));
    }
  }

  FutureOr<void> _onSeatsRefreshed(
    SeatsRefreshed event,
    Emitter<SeatsState> emit,
  ) {}
}
