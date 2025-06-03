import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/presentation/film_detail/film_information/cubit/check_overfolw.state.dart';

class CheckOverFlowCubit extends Cubit<CheckOverflowState> {
  CheckOverFlowCubit() : super(CheckOverflowState());

  void expand() => emit(state.copyWith(expanded: true));

  void checkOverflow({
    required String value,
    required TextStyle textStyle,
    required double maxWidth,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(text: value, style: textStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    if (textPainter.didExceedMaxLines) {
      emit(state.copyWith(overflow: true));
    }
  }
}
