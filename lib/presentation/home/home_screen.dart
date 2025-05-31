import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/data/repositories/film.dart';
import 'package:rt_mobile/presentation/home/bloc/film/bloc.dart';
import 'package:rt_mobile/presentation/home/widgets/export.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filmRepository = RepositoryProvider.of<FilmRepository>(context);

    return BlocProvider(
      create:
          (_) => FilmBloc(filmRepository: filmRepository)..add(FilmFetched()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          elevation: 0,
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 10),
              const Text(
                'Xin chào!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [FilmCarousel()],
          ),
        ),
      ),
    );
  }
}
