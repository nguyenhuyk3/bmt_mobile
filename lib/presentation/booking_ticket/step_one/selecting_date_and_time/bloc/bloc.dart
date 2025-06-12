import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/data/models/showtime/showtime.showtime.dart';
import 'package:rt_mobile/data/repositories/showtime.dart';

part 'event.dart';
part 'state.dart';

class SelectingDateAndTimeBloc
    extends Bloc<SelectingDateAndTimeEvent, SelectingDateAndTimeState> {
  final ShowtimeRepository showtimeRepository;

  SelectingDateAndTimeBloc({required this.showtimeRepository})
    : super(SelectingDateAndTimeInitial()) {
    on<SelectingDateAndTimeFetched>(_onSelectingDateAndTimeFetched);
    on<SelectingDateAndTimeRefreshed>(_onSelectingDateAndTimeRefreshed);
    on<SelectingDateAndTimeDateChanged>(_onSelectingDateAndTimeDateChanged);
    on<SelectingDateAndTimeTimeChanged>(_onSelectingDateAndTimeTimeChanged);
  }

  FutureOr<void> _onSelectingDateAndTimeFetched(
    SelectingDateAndTimeFetched event,
    Emitter<SelectingDateAndTimeState> emit,
  ) async {
    emit(SelectingDateAndTimeLoading());

    try {
      final showtimes = await showtimeRepository
          .getAllShowtimesByFilmIdAndByCinemaIdAndInDayRange(
            filmId: event.filmId,
            cinemaId: event.cinemaId,
          );

      emit(SelectingDateAndTimeLoadSuccess(showtimes: showtimes));
    } catch (e) {
      emit(SelectingDateAndTimeLoadFailed(message: e.toString()));
    }
  }

  FutureOr<void> _onSelectingDateAndTimeRefreshed(
    SelectingDateAndTimeRefreshed event,
    Emitter<SelectingDateAndTimeState> emit,
  ) {}

  FutureOr<void> _onSelectingDateAndTimeDateChanged(
    SelectingDateAndTimeDateChanged event,
    Emitter<SelectingDateAndTimeState> emit,
  ) {}

  FutureOr<void> _onSelectingDateAndTimeTimeChanged(
    SelectingDateAndTimeTimeChanged event,
    Emitter<SelectingDateAndTimeState> emit,
  ) {}
}
