class CheckOverflowState {
  // Check if the text has been expanded or not
  final bool expanded;
  // Check if the text has been overflowed or not
  final bool overflow;

  CheckOverflowState({this.expanded = false, this.overflow = false});

  CheckOverflowState copyWith({bool? expanded, bool? overflow}) {
    return CheckOverflowState(
      expanded: expanded ?? this.expanded,
      overflow: overflow ?? this.overflow,
    );
  }
}

