import 'package:flutter/material.dart';
import 'package:rt_mobile/data/models/film/film.dart';

class MovieCarousell extends StatefulWidget {
  final List<Film> films;

  const MovieCarousell({super.key, required this.films});

  @override
  State<MovieCarousell> createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousell> {
  /* 
      PageController in Flutter is a class used to control pages in a PageView widget
    or similar widgets that can scroll horizontally or vertically.
      Properties:
        - viewportFraction: is a property of PageController in Flutter, used to determine the percentage of the viewport
        that each page occupies on the screen.
  */
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.70, initialPage: 0);
    _pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    final newPage = _pageController.page?.round() ?? 0;
    if (newPage != _currentPage) {
      setState(() {
        _currentPage = newPage;
      });
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
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
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.72,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.films.length,
            itemBuilder: (context, index) {
              final film = widget.films[index];
              return _CenteredMovieCard(
                film: film,
                index: index,
                pageController: _pageController,
              );
            },
          ),
        ),
        SizedBox(height: 5),
        _MovieIndicator(
          length: widget.films.length,
          currentIndex: _currentPage,
        ),
      ],
    );
  }
}

class _MovieIndicator extends StatelessWidget {
  const _MovieIndicator({required this.length, required this.currentIndex});

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

class _CenteredMovieCard extends StatelessWidget {
  const _CenteredMovieCard({
    required this.film,
    required this.index,
    required this.pageController,
  });

  final Film film;
  final int index;
  final PageController pageController;

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
