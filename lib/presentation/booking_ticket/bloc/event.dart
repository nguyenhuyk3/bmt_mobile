part of 'bloc.dart';

sealed class BookingTicketEvent extends Equatable {
  const BookingTicketEvent();

  @override
  List<Object> get props => [];
}

class BookingTicketAddSeatToOrder extends BookingTicketEvent {
  final SeatShowtime seat;

  const BookingTicketAddSeatToOrder({required this.seat});

  @override
  List<Object> get props => [seat];
}

class BookingTicketRemoveSeatFromOrder extends BookingTicketEvent {
  final SeatShowtime seat;

  const BookingTicketRemoveSeatFromOrder({required this.seat});

  @override
  List<Object> get props => [seat];
}

class BookingTicketAddFABToOrder extends BookingTicketEvent {
  final FABProduct fAB;

  const BookingTicketAddFABToOrder({required this.fAB});

  @override
  List<Object> get props => [fAB];
}

class BookingTicketRemoveFABFromOrder extends BookingTicketEvent {
  final FABProduct fAB;

  const BookingTicketRemoveFABFromOrder({required this.fAB});

  @override
  List<Object> get props => [fAB];
}

class BookingTicketClearOrder extends BookingTicketEvent {}
