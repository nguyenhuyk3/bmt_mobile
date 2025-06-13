part of 'bloc.dart';

class BookingTicketState extends Equatable {
  final FilmProduct film;
  final List<CartItem> fABs;
  final List<SeatShowtime> seats;
  final String showDate;
  final String startTime;
  final double totalAmount;
  final String messageError;

  BookingTicketState({
    FilmProduct? film,
    this.fABs = const [],
    this.seats = const [],
    this.showDate = '',
    this.startTime = '',
    this.totalAmount = 0.0,
    this.messageError = '',
  }) : film = film ?? FilmProduct.empty();

  BookingTicketState copyWith({
    FilmProduct? film,
    List<CartItem>? fABs,
    List<SeatShowtime>? seats,
    String? showDate,
    String? startTime,
    double? totalAmount,
    String? messageError,
  }) {
    return BookingTicketState(
      film: film ?? this.film,
      fABs: fABs ?? this.fABs,
      seats: seats ?? this.seats,
      showDate: showDate ?? this.showDate,
      startTime: startTime ?? this.startTime,
      totalAmount: totalAmount ?? this.totalAmount,
      messageError: messageError ?? this.messageError,
    );
  }

  @override
  List<Object?> get props => [film, fABs, seats, totalAmount, messageError];
}
