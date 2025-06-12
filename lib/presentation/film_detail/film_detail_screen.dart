import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rt_mobile/data/repositories/cinema.dart';
import 'package:rt_mobile/data/repositories/film.dart';
import 'package:rt_mobile/presentation/booking_ticket/bloc/bloc.dart';
import 'package:rt_mobile/presentation/film_detail/available_cinema/bloc/bloc.dart';
import 'package:rt_mobile/presentation/film_detail/available_cinema/view/available_cinema.dart';
import 'package:rt_mobile/presentation/film_detail/film_information/bloc/bloc.dart';
import 'package:rt_mobile/presentation/film_detail/film_information/view/film_information.dart';

class FilmDetailScreen extends StatelessWidget {
  final int filmId;

  const FilmDetailScreen({super.key, required this.filmId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final bloc = FilmInformationBloc(
              filmRepository: RepositoryProvider.of<FilmRepository>(context),
            );

            bloc.add(FilmInfomationFetched(filmId: filmId));

            return bloc;
          },
        ),
        BlocProvider(
          create: (_) {
            final bloc = AvailableCinemaBloc(
              cinemaRepository: RepositoryProvider.of<CinemaRepository>(
                context,
              ),
            );

            bloc.add(AvailableCinemaFetched(filmId: filmId));

            return bloc;
          },
        ),
        BlocProvider(create: (_) => BookingTicketBloc()),
      ],
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView(children: [FilmInformation(), AvaibleCinema()]),
        ),
      ),
    );
  }
}
