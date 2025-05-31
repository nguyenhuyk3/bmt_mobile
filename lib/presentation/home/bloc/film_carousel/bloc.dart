import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/data/models/film/film.dart';
import 'package:rt_mobile/data/repositories/film.dart';

part 'event.dart';
part 'state.dart';

class FilmCarouselBloc extends Bloc<FilmCarouselEvent, FilmCarouselState> {
  final FilmRepository filmRepository;

  FilmCarouselBloc({required this.filmRepository})
    : super(FilmCarouselInitial()) {
    on<FilmCarouselFetched>(_onFilmsFetched);
    on<FilmCarouselRefreshed>(_onFilmsRefreshed);
  }

  FutureOr<void> _onFilmsFetched(
    FilmCarouselFetched event,
    Emitter<FilmCarouselState> emit,
  ) async {
    emit(FilmCarouselLoading());

    try {
      final films = await filmRepository.getAllFilmsCurrentlyShowing();
      
      emit(FilmCarouselLoadSuccess(film: films));
    } catch (e) {
      emit(FilmCarouselLoadFailed(message: e.toString()));
    }
  }

  FutureOr<void> _onFilmsRefreshed(
    FilmCarouselRefreshed event,
    Emitter<FilmCarouselState> emit,
  ) {}
}
