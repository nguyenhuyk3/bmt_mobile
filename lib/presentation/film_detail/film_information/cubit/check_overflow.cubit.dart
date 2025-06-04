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
    /* 
    What is TextPainter?
    ---------------------
    TextPainter is a Flutter class used to measure and render text manually.
    It's commonly used when you need low-level control over text layout,
    such as measuring whether text overflows a given width.
  */
    final textPainter = TextPainter(
      // text: A TextSpan containing the text to measure.
      // style: The style to use for measurement (should match the UI style).
      text: TextSpan(text: value, style: textStyle),

      // maxLines: Limits the text layout to a maximum of one line.
      maxLines: 1,

      // textDirection: Specifies the direction of the text (e.g., left-to-right).
      textDirection: TextDirection.ltr,

      // ..layout(maxWidth): Measures the text within the given maximum width.
    )..layout(maxWidth: maxWidth);

    // textPainter.didExceedMaxLines:
    // Returns true if the text exceeds the allowed number of lines (in this case, 1).
    if (textPainter.didExceedMaxLines) {
      // Update the state to indicate overflow = true.
      emit(state.copyWith(overflow: true));
    }
  }
}
