String extractStartTime({required String input}) {
  final parts = input.split('-');

  return parts.length > 1 ? parts[1] : '';
}

String extractShowtimeId({required String input}) {
  final parts = input.split('-');

  return parts.isNotEmpty ? parts[0] : '';
}
