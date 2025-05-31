import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/data/models/film/film.dart';
import 'package:rt_mobile/data/repositories/film.dart';

part 'event.dart';
part 'state.dart';

class FilmBloc extends Bloc<FilmEvent, FilmState> {
  final FilmRepository filmRepository;

  FilmBloc({required this.filmRepository})
    : super(FilmInitial()) {
    on<FilmFetched>(_onFilmsFetched);
    on<FilmRefreshed>(_onFilmsRefreshed);
  }

  FutureOr<void> _onFilmsFetched(
    FilmFetched event,
    Emitter<FilmState> emit,
  ) async {
    emit(FilmLoading());

    try {
      final films = await filmRepository.getAllFilmsCurrentlyShowing();
      
      emit(FilmLoadSuccess(film: films));
    } catch (e) {
      emit(FilmLoadFailed(message: e.toString()));
    }
  }

  FutureOr<void> _onFilmsRefreshed(
    FilmRefreshed event,
    Emitter<FilmState> emit,
  ) {}
}
