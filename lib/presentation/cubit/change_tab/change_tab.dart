import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeTabCubit<T> extends Cubit<T> {
  ChangeTabCubit({required T initialState}) : super(initialState);

  void changeTab(T value) {
    emit(value);
  }
}
