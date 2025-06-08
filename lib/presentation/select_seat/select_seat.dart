import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/data/repositories/showtime.dart';
import 'package:rt_mobile/presentation/select_seat/selecting_date_and_time/bloc/bloc.dart';
import 'package:rt_mobile/presentation/select_seat/selecting_date_and_time/view/selecting_date_and_time.dart';

class SelectSeatScreen extends StatelessWidget {
  const SelectSeatScreen({super.key});

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
      ],
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Đặt ghế", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
          leading: const BackButton(color: Colors.white),
          elevation: 0,
        ),
        body: Column(children: [SelectingDateAndTime()]),
      ),
    );
  }
}
