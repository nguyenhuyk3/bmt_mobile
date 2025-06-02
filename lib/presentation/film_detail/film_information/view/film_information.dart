import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rt_mobile/data/models/film/film.product.dart';
import 'package:rt_mobile/presentation/film_detail/film_information/bloc/bloc.dart';
import 'package:rt_mobile/presentation/splash/spash_view.dart';

class FilmInformation extends StatelessWidget {
  const FilmInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilmInformationBloc, FilmInformationState>(
      builder: (context, state) {
        if (state is FilmInformationLoadSuccess) {
          return _FilmInformationContainer(film: state.film);
        } else if (state is FilmInformationLoading) {
          return SplashPage();
        } else {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text(
                'Đã có lỗi xảy ra',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class _FilmInformationContainer extends StatelessWidget {
  final FilmProduct film;

  const _FilmInformationContainer({required this.film});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FilmPoster(filmPoster: film.posterUrl),

            const SizedBox(height: 12),

            Text(
              film.title,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              '${film.duration} • ${film.releaseDate}',
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 8),

            _FilmReview(),

            const Divider(color: Colors.grey),

            _FilmInfos(film: film),

            const SizedBox(height: 10),

            _FilmStoryLine(storyLine: film.description),

            _FilmDirectorOrActorInfo(
              title: 'Đạo diễn',
              people: [
                {
                  'name': 'Anthony Russo',
                  'img': 'https://i.pravatar.cc/100?img=11',
                },
                {
                  'name': 'Joe Russo',
                  'img': 'https://i.pravatar.cc/100?img=12',
                },
              ],
            ),

            _FilmDirectorOrActorInfo(
              title: 'Diễn viên',
              people: [
                {
                  'name': 'Robert Downey Jr.',
                  'img': 'https://i.pravatar.cc/100?img=1',
                },
                {
                  'name': 'Chris Hemsworth',
                  'img': 'https://i.pravatar.cc/100?img=2',
                },
                {
                  'name': 'Chris Evans',
                  'img': 'https://i.pravatar.cc/100?img=3',
                },
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FilmPoster extends StatelessWidget {
  final String filmPoster;

  const _FilmPoster({required this.filmPoster});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(filmPoster),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}

class _FilmReview extends StatelessWidget {
  const _FilmReview();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber),
        const SizedBox(width: 4),
        const Text('4.8 ', style: TextStyle(color: Colors.white)),
        const Text('(1.2k)', style: TextStyle(color: Colors.grey)),
        const Spacer(),
        ElevatedButton(
          onPressed: () {},
          child: const Text(
            'Xem trailer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatefulWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  State<_InfoRow> createState() => _InfoRowState();
}

class _InfoRowState extends State<_InfoRow> {
  bool expanded = false;
  bool overflow = false;

  final TextStyle valueStyle = const TextStyle(color: Colors.white);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkOverflow());
  }

  void checkOverflow() {
    final textPainter = TextPainter(
      text: TextSpan(text: widget.value, style: valueStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(
      maxWidth: MediaQuery.of(context).size.width - 150,
    ); // trừ label width + padding

    if (textPainter.didExceedMaxLines) {
      setState(() {
        overflow = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              widget.label,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.value,
                  style: valueStyle,
                  maxLines: expanded ? null : 1,
                  overflow:
                      expanded ? TextOverflow.visible : TextOverflow.ellipsis,
                ),
                if (overflow && !expanded)
                  GestureDetector(
                    onTap: () => setState(() => expanded = true),
                    child: const Text(
                      'Xem thêm',
                      style: TextStyle(color: Colors.amber, fontSize: 12),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilmInfos extends StatelessWidget {
  final FilmProduct film;

  const _FilmInfos({required this.film});

  String capitalize(String text) {
    if (text.isEmpty) return text;

    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final formattedGenres = film.genres.map(capitalize).join(', ');

    return Column(
      children: [
        _InfoRow(label: 'Thể loại phim:', value: formattedGenres),
        _InfoRow(label: 'Kiểm duyệt:', value: '13+'),
        _InfoRow(label: 'Ngôn ngữ:', value: 'English'),
      ],
    );
  }
}

class _FilmStoryLine extends StatelessWidget {
  final String storyLine;

  const _FilmStoryLine({required this.storyLine});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Cốt truyện',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        Text(storyLine, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}

class _FilmDirectorOrActorInfo extends StatelessWidget {
  final String title;
  final List<Map<String, String>> people;

  const _FilmDirectorOrActorInfo({required this.title, required this.people});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children:
              people.map((person) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(person['img']!),
                        radius: 24,
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 60,
                        child: Text(
                          person['name']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
