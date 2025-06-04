import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/data/models/film/film.product.dart';
import 'package:rt_mobile/data/repositories/film.dart';

part 'state.dart';
part 'event.dart';

class FilmInformationBloc
    extends Bloc<FilmInfomationEvent, FilmInformationState> {
  final FilmRepository filmRepository;

  FilmInformationBloc({required this.filmRepository})
    : super(FilmInformationInitial()) {
    on<FilmInfomationFetched>(_onFilmInfomationFetched);
    on<FilmInfomationRefreshed>(_onFilmInfomationRefreshed);
  }

  FutureOr<void> _onFilmInfomationFetched(
    FilmInfomationFetched event,
    Emitter<FilmInformationState> emit,
  ) async {
    emit(FilmInformationLoading());

    try {
      final film = await filmRepository.getFilmById(filmId: event.filmId);

      emit(FilmInformationLoadSuccess(film: film));
    } catch (e) {
      emit(FilmInformationLoadFailed(message: e.toString()));
    }
  }

  FutureOr<void> _onFilmInfomationRefreshed(
    FilmInfomationRefreshed event,
    Emitter<FilmInformationState> emit,
  ) {}
}
