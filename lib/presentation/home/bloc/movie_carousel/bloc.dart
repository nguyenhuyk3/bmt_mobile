import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/data/models/movie/movie.dart';

part 'event.dart';
part 'state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  MovieCarouselBloc() : super(MovieCarouselInitial()) {

  }
}