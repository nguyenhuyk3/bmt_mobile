part of 'bloc.dart';

class BookingTicketState extends Equatable {
  final FilmProduct film;
  final List<FABProduct> fABs;
  final List<SeatShowtime> seats;
  final double totalAmount;
  final String messageError;

  BookingTicketState({
    FilmProduct? film,
    this.fABs = const [],
    this.seats = const [],
    this.totalAmount = 0.0,
    this.messageError = '',
  }) : film = film ?? FilmProduct.empty();

  BookingTicketState copyWith({
    FilmProduct? film,
    List<FABProduct>? fABs,
    List<SeatShowtime>? seats,
    double? totalAmount,
    String? messageError,
  }) {
    return BookingTicketState(
      film: film ?? this.film,
      fABs: fABs ?? this.fABs,
      seats: seats ?? this.seats,
      totalAmount: totalAmount ?? this.totalAmount,
      messageError: messageError ?? this.messageError,
    );
  }

  @override
  List<Object?> get props => [film, fABs, seats, totalAmount, messageError];
}
