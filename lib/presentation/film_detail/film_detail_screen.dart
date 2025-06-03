import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/data/repositories/cinema.dart';
import 'package:rt_mobile/data/repositories/film.dart';
import 'package:rt_mobile/presentation/film_detail/available_cinema/bloc/bloc.dart';
import 'package:rt_mobile/presentation/film_detail/available_cinema/view/available_cinema.dart';
import 'package:rt_mobile/presentation/film_detail/film_information/bloc/bloc.dart';
import 'package:rt_mobile/presentation/film_detail/film_information/cubit/check_overflow.cubit.dart';
import 'package:rt_mobile/presentation/film_detail/film_information/view/film_information.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final bloc = FilmInformationBloc(
              filmRepository: RepositoryProvider.of<FilmRepository>(context),
            );

            bloc.add(FilmInfomationFetched());

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

            bloc.add(AvailableCinemaFetched());

            return bloc;
          },
        ),
        // BlocProvider(create: (_) => CheckOverFlowCubit()),
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
