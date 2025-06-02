import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/data/repositories/film.dart';
import 'package:rt_mobile/presentation/film_detail/film_information/bloc/bloc.dart';
import 'package:rt_mobile/presentation/film_detail/film_information/view/film_information.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filmRepository = RepositoryProvider.of<FilmRepository>(context);

    return BlocProvider(
      create:
          (_) =>
              FilmInformationBloc(filmRepository: filmRepository)
                ..add(FilmInfomationFetched()),
      child: Scaffold(body: ListView(children: [FilmInformation()])),
    );
  }
}
