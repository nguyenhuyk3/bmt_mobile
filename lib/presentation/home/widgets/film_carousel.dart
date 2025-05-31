import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/data/models/export.dart';
import 'package:rt_mobile/presentation/home/cubit/film_carousel.dart';

class FilmCarousel extends StatelessWidget {
  final List<Film> films;
  final PageController _pageController = PageController(
    viewportFraction: 0.7,
    initialPage: 0,
  );

  FilmCarousel({super.key, required this.films});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FilmCarouselCubit(),
      child: Builder(
        builder: (context) {
          _pageController.addListener(() {
            final newPage = _pageController.page?.round() ?? 0;
            if (newPage != context.read<FilmCarouselCubit>().state) {
              context.read<FilmCarouselCubit>().moveFilm(newPage);
            }
          });

          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _Header(),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.72,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: films.length,
                  itemBuilder: (context, index) {
                    final film = films[index];
                    return _CenteredFilmCard(
                      film: film,
                      index: index,
                      pageController: _pageController,
                    );
                  },
                ),
              ),

              BlocBuilder<FilmCarouselCubit, int>(
                builder: (context, currentIndex) {
                  return _FilmIndicator(
                    length: films.length,
                    currentIndex: currentIndex,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, top: 10),
          child: Text(
            'Đang công chiếu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _CenteredFilmCard extends StatelessWidget {
  final Film film;
  final int index;
  final PageController pageController;

  const _CenteredFilmCard({
    required this.film,
    required this.index,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: AnimatedBuilder(
        animation: pageController,
        builder: (context, child) {
          double page =
              pageController.hasClients &&
                      pageController.position.haveDimensions
                  ? pageController.page!
                  : pageController.initialPage.toDouble();
          double diff = (page - index).abs();
          double scale = (1 - diff * 0.2).clamp(0.8, 1.0);
          double opacity = (1 - diff * 0.5).clamp(0.5, 1.0);
          double translateY = (1 - scale) * 50;

          return Opacity(
            opacity: opacity,
            child: Transform.translate(
              offset: Offset(0, translateY),
              child: Transform.scale(scale: scale, child: child),
            ),
          );
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                film.posterUrl,
                height: 480,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              film.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${film.duration} • ${film.genres}',
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  '\${movie.rating}',
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
                const SizedBox(width: 4),
                Text(
                  '(\${movie.votes})',
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FilmIndicator extends StatelessWidget {
  const _FilmIndicator({required this.length, required this.currentIndex});

  final int length;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? Colors.yellowAccent : Colors.white24,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
