import 'package:flutter_bloc/flutter_bloc.dart';

class FilmCarouselCubit extends Cubit<int> {
  FilmCarouselCubit() : super(0);

  void moveFilm(int index) {
    emit(index);
  }
}
