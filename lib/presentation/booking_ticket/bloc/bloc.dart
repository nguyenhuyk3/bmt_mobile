import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rt_mobile/data/models/product/fab.product.dart';
import 'package:rt_mobile/data/models/showtime/seat.showtime.dart';

part 'event.dart';
part 'state.dart';

class BookingTicketBloc extends Bloc<BookingTicketEvent, BookingTicketState> {
  BookingTicketBloc() : super(const BookingTicketState()) {
    on<BookingTicketAddSeatToOrder>(_onAddSeat);
    on<BookingTicketRemoveSeatFromOrder>(_onRemoveSeat);
    on<BookingTicketAddFABToOrder>(_onAddFAB);
    on<BookingTicketRemoveFABFromOrder>(_onRemoveFAB);
    on<BookingTicketClearOrder>(_onClearOrder);
  }

  void _onAddSeat(
    BookingTicketAddSeatToOrder event,
    Emitter<BookingTicketState> emit,
  ) {
    final updatedSeats = List<SeatShowtime>.from(state.seats);

    if (!updatedSeats.contains(event.seat)) {
      updatedSeats.add(event.seat);
    }

    final total = _calculateTotal(updatedSeats, state.fABs);

    emit(state.copyWith(seats: updatedSeats, totalAmount: total));
  }

  void _onRemoveSeat(
    BookingTicketRemoveSeatFromOrder event,
    Emitter<BookingTicketState> emit,
  ) {
    final updatedSeats =
        state.seats.where((s) => s.id != event.seat.id).toList();
    final total = _calculateTotal(updatedSeats, state.fABs);

    emit(state.copyWith(seats: updatedSeats, totalAmount: total));
  }

  void _onAddFAB(
    BookingTicketAddFABToOrder event,
    Emitter<BookingTicketState> emit,
  ) {
    final updatedFABs = List<FABProduct>.from(state.fABs);

    updatedFABs.add(event.fAB);

    final total = _calculateTotal(state.seats, updatedFABs);

    emit(state.copyWith(fABs: updatedFABs, totalAmount: total));
  }

  void _onRemoveFAB(
    BookingTicketRemoveFABFromOrder event,
    Emitter<BookingTicketState> emit,
  ) {
    final updatedFABs = List<FABProduct>.from(state.fABs);
    final index = updatedFABs.indexWhere((fab) => fab.id == event.fAB.id);

    if (index != -1) {
      updatedFABs.removeAt(index);
    }

    final total = _calculateTotal(state.seats, updatedFABs);

    emit(state.copyWith(fABs: updatedFABs, totalAmount: total));
  }

  double _calculateTotal(List<SeatShowtime> seats, List<FABProduct> fabs) {
    final seatTotal = seats.fold<double>(
      0.0,
      (sum, s) => sum + s.price.toDouble(),
    );
    final fabTotal = fabs.fold<double>(0.0, (sum, f) => sum + f.price);

    return seatTotal + fabTotal;
  }

  FutureOr<void> _onClearOrder(
    BookingTicketClearOrder event,
    Emitter<BookingTicketState> emit,
  ) {
    emit(state.copyWith(seats: [], fABs: [], totalAmount: 0.0));
  }
}
