class ChoseCinemaState {
  final int selectedIndex;
  final int selectedCinemaId;

  ChoseCinemaState({this.selectedIndex = 0, this.selectedCinemaId = -1});

  ChoseCinemaState copyWith({int? selectedIndex, int? selectedCinemaId}) {
    return ChoseCinemaState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedCinemaId: selectedCinemaId ?? this.selectedCinemaId,
    );
  }
}
