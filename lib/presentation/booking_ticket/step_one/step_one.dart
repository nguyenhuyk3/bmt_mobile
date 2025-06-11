import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/data/repositories/showtime.dart';
import 'package:rt_mobile/presentation/booking_ticket/step_one/seats/bloc/bloc.dart';
import 'package:rt_mobile/presentation/booking_ticket/step_one/seats/view/seats.dart';
import 'package:rt_mobile/presentation/booking_ticket/step_one/seats/view/selected_seats_summary.dart';
import 'package:rt_mobile/presentation/booking_ticket/step_one/selecting_date_and_time/bloc/bloc.dart';
import 'package:rt_mobile/presentation/booking_ticket/step_one/selecting_date_and_time/view/selecting_date_and_time.dart';

class StepOneScreen extends StatelessWidget {
  const StepOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final bloc = SelectingDateAndTimeBloc(
              showtimeRepository: RepositoryProvider.of<ShowtimeRepository>(
                context,
              ),
            );

            bloc.add(SelectingDateAndTimeFetched());

            return bloc;
          },
        ),
        BlocProvider(
          create: (_) {
            final bloc = SeatsBloc(
              showtimeRepository: RepositoryProvider.of<ShowtimeRepository>(
                context,
              ),
            );

            bloc.add(SeatsFetched(showtimeId: -1));

            return bloc;
          },
        ),
      ],
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 32),

            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const Center(
                  child: Text(
                    "Đặt ghế",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            Seats(),

            SizedBox(height: 18),

            Text(
              "Chọn ngày và giờ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: 18),

            SelectingDateAndTime(),

            Divider(color: Colors.grey, thickness: 0.4),

            SizedBox(height: 12),

            SelectedSeatSummary(),
          ],
        ),
      ),
    );
  }
}
