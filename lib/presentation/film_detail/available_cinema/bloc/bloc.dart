import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rt_mobile/data/models/cinema/cinema.showtime.dart';
import 'package:rt_mobile/data/repositories/cinema.dart';

part 'event.dart';
part 'state.dart';

class AvailableCinemaBloc
    extends Bloc<AvailableCinemaEvent, AvailableCinemaState> {
  final CinemaRepository cinemaRepository;

  AvailableCinemaBloc({required this.cinemaRepository})
    : super(AvailableCinemaInitial()) {
    on<AvailableCinemaFetched>(_onAvailableCinemaFetched);
    on<AvailableCinemaRefreshed>(_onAvailableCinemaRefreshed);
  }

  FutureOr<void> _onAvailableCinemaFetched(
    AvailableCinemaFetched event,
    Emitter<AvailableCinemaState> emit,
  ) async {
    emit(AvailableCinemaLoading());

    try {
      final cinemas = await cinemaRepository.getCinemasForShowingFilmByFilmId(
        filmId: event.filmId,
      );

      emit(AvailableCinemaLoadSuccess(cinemas: cinemas));
    } catch (e) {
      emit(AvailableCinemaLoadFailed(message: e.toString()));
    }
  }

  FutureOr<void> _onAvailableCinemaRefreshed(
    AvailableCinemaRefreshed event,
    Emitter<AvailableCinemaState> emit,
  ) {}
}
