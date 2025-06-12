part of 'bloc.dart';

class BookingTicketState extends Equatable {
  final List<FABProduct> fABs;
  final List<SeatShowtime> seats;
  final double totalAmount;

  const BookingTicketState({
    this.fABs = const [],
    this.seats = const [],
    this.totalAmount = 0.0,
  });

  BookingTicketState copyWith({
    List<FABProduct>? fABs,
    List<SeatShowtime>? seats,
    double? totalAmount,
    bool? isLoading,
    bool? orderProcessed,
    String? errorMessage,
  }) {
    return BookingTicketState(
      fABs: fABs ?? this.fABs,
      seats: seats ?? this.seats,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  @override
  List<Object?> get props => [fABs, seats, totalAmount];
}
