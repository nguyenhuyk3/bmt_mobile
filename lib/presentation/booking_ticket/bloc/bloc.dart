import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/data/models/film/film.product.dart';
import 'package:rt_mobile/data/models/product/cart.dart';

import 'package:rt_mobile/data/models/product/fab.product.dart';
import 'package:rt_mobile/data/models/showtime/seat.showtime.dart';
import 'package:rt_mobile/data/repositories/film.dart';

part 'event.dart';
part 'state.dart';

class BookingTicketBloc extends Bloc<BookingTicketEvent, BookingTicketState> {
  final FilmRepository filmRepository;

  BookingTicketBloc({required this.filmRepository})
    : super(BookingTicketState()) {
    on<BookingTicketGetFilm>(_onGetFilm);
    on<BookingTicketAddSeatToOrder>(_onAddSeat);
    on<BookingTicketRemoveSeatFromOrder>(_onRemoveSeat);
    on<BookingTicketAddFABToOrder>(_onAddFAB);
    on<BookingTicketRemoveFABFromOrder>(_onRemoveFAB);
    on<BookingTicketClearOrder>(_onClearOrder);
    on<BookingTicketChoseStartTime>(_onChoseStartTime);
  }

  void _onAddSeat(
    BookingTicketAddSeatToOrder event,
    Emitter<BookingTicketState> emit,
  ) {
    final updatedSeats = List<SeatShowtime>.from(state.seats);

    if (!updatedSeats.contains(event.seat)) {
      updatedSeats.add(event.seat);
    }

    final total = _calculateTotal(
      updatedSeats,
      state.fABs,
      isCoupled: event.isCoupled,
    );

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
    final updatedFABs = List<CartItem>.from(state.fABs);

    // Tìm xem sản phẩm đã có trong cart chưa
    final existingIndex = updatedFABs.indexWhere(
      (item) => item.fABProduct.id == event.fAB.id,
    );

    if (existingIndex != -1) {
      // Nếu đã có, tăng quantity
      final existingItem = updatedFABs[existingIndex];
      updatedFABs[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      );
    } else {
      // Nếu chưa có, thêm mới
      updatedFABs.add(CartItem(fABProduct: event.fAB, quantity: 1));
    }

    final total = _calculateTotal(state.seats, updatedFABs);

    emit(state.copyWith(fABs: updatedFABs, totalAmount: total));
  }

  void _onRemoveFAB(
    BookingTicketRemoveFABFromOrder event,
    Emitter<BookingTicketState> emit,
  ) {
    final updatedFABs = List<CartItem>.from(state.fABs);

    final existingIndex = updatedFABs.indexWhere(
      (item) => item.fABProduct.id == event.fAB.fABProduct.id,
    );

    if (existingIndex != -1) {
      final existingItem = updatedFABs[existingIndex];

      if (existingItem.quantity > 1) {
        // Nếu quantity > 1, giảm quantity
        updatedFABs[existingIndex] = existingItem.copyWith(
          quantity: existingItem.quantity - 1,
        );
      } else {
        // Nếu quantity = 1, xóa khỏi cart
        updatedFABs.removeAt(existingIndex);
      }
    }

    final total = _calculateTotal(state.seats, updatedFABs);

    emit(state.copyWith(fABs: updatedFABs, totalAmount: total));
  }

  double _calculateTotal(
    List<SeatShowtime> seats,
    List<CartItem> fabs, {
    bool isCoupled = false,
  }) {
    final seatTotal = seats.fold<double>(0.0, (sum, seat) {
      final price = seat.price.toDouble();

      return sum +
          (seat.seatType == 'coupled' || isCoupled ? price * 2 : price);
    });

    final fabTotal = fabs.fold<double>(
      0.0,
      (sum, cartItem) => sum + (cartItem.fABProduct.price * cartItem.quantity),
    );

    return seatTotal + fabTotal;
  }

  void _onClearOrder(
    BookingTicketClearOrder event,
    Emitter<BookingTicketState> emit,
  ) {
    emit(state.copyWith(seats: [], fABs: [], totalAmount: 0.0));
  }

  FutureOr<void> _onGetFilm(
    BookingTicketGetFilm event,
    Emitter<BookingTicketState> emit,
  ) async {
    try {
      final film = await filmRepository.getFilmById(filmId: event.filmId);

      emit(state.copyWith(film: film));
    } catch (e) {
      emit(state.copyWith(messageError: e.toString()));
    }
  }

  FutureOr<void> _onChoseStartTime(
    BookingTicketChoseStartTime event,
    Emitter<BookingTicketState> emit,
  ) {
    emit(state.copyWith(showDate: event.showDate, startTime: event.startTime));
  }
}
