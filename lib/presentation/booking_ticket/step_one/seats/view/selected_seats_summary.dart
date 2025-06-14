import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/presentation/booking_ticket/bloc/bloc.dart';

import 'package:rt_mobile/presentation/booking_ticket/step_one/seats/bloc/bloc.dart';
import 'package:rt_mobile/presentation/booking_ticket/step_two/selecting_fab/bloc/bloc.dart';
import 'package:rt_mobile/presentation/booking_ticket/step_two/step_two.dart';

class SelectedSeatSummaryView extends StatelessWidget {
  const SelectedSeatSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeatsBloc, SeatsState>(
      builder: (context, state) {
        int total = 0;

        if (state is SeatsLoadSuccess) {
          final selectedSeats =
              state.seats
                  .where((seat) => state.selectedSeatIds.contains(seat.seatId))
                  .toList();

          total = selectedSeats.fold<int>(0, (sum, seat) {
            if (seat.seatType == 'coupled') {
              return sum + (seat.price * 2);
            }

            return sum + seat.price;
          });
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: const BoxDecoration(
            color: Colors.black,
            border: Border(top: BorderSide(color: Colors.grey, width: 0.2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Tổng tiền\n',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          '${total.toString().replaceAllMapped(RegExp(r"(\d)(?=(\d{3})+(?!\d))"), (match) => "${match[1]}.")} VND',
                      style: const TextStyle(
                        color: Colors.amberAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed:
                    total > 0
                        ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(
                                        value: context.read<SelectingFABBloc>(),
                                      ),
                                      BlocProvider.value(
                                        value:
                                            context.read<BookingTicketBloc>(),
                                      ),
                                    ],
                                    child: StepTwoScreen(),
                                  ),
                            ),
                          );
                        }
                        : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
                  disabledBackgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Tiếp tục',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
