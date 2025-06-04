import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rt_mobile/presentation/film_detail/available_cinema/cubit/chose_cinema.state.dart';

class ChoseCinemaCubit extends Cubit<ChoseCinemaState> {
  ChoseCinemaCubit() : super(ChoseCinemaState());

  void choseCinema({
    required int selectedIndex,
    required int selectedCinemaId,
  }) {
    emit(
      ChoseCinemaState(
        selectedIndex: selectedIndex,
        selectedCinemaId: selectedCinemaId,
      ),
    );
  }
}
