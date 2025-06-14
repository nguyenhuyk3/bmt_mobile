import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rt_mobile/data/models/film/film.product.dart';
import 'package:rt_mobile/presentation/film_detail/film_information/bloc/bloc.dart';
import 'package:rt_mobile/presentation/film_detail/film_information/cubit/check_overflow.cubit.dart';
import 'package:rt_mobile/presentation/film_detail/film_information/cubit/check_overfolw.state.dart';
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
                'Máy chủ đã xảy ra lỗi',
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
    /*
      SafeArea is a widget in Flutter that is used to ensure your content is not obscured by things like:
      - Notch on iPhone
      - Status bar
      - Navigation bar
      - Borders or collapsed devices
    */
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FilmPoster(filmPoster: film.posterUrl),

          const SizedBox(height: 12),

          Text(
            film.title,
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            '${film.duration} • ${film.releaseDate}',
            style: const TextStyle(color: Colors.grey, fontSize: 15),
          ),

          const SizedBox(height: 8),

          _FilmReview(),

          const Divider(color: Colors.grey),

          _FilmInfos(film: film),

          const SizedBox(height: 12),

          _FilmStoryLine(storyLine: film.description),

          _FilmDirectorOrActorInfo(
            title: 'Đạo diễn',
            people: [
              {
                'name': 'Anthony Russo',
                'img': 'https://i.pravatar.cc/100?img=11',
              },
              {'name': 'Joe Russo', 'img': 'https://i.pravatar.cc/100?img=12'},
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
              {'name': 'Chris Evans', 'img': 'https://i.pravatar.cc/100?img=3'},
            ],
          ),
        ],
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
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
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
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amberAccent,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'Xem trailer',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CheckOverFlowCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<CheckOverFlowCubit>();
          final textStyle = const TextStyle(color: Colors.white, fontSize: 15);

          /* 
              This code registers a callback function to be called after the current frame has finished rendering 
            (i.e. after the UI build and layout is complete)
              addPostFrameCallback is used to delay running the code until the UI has finished rendering
          */
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final maxWidth = MediaQuery.of(context).size.width - 150;

            cubit.checkOverflow(
              value: value,
              textStyle: textStyle,
              maxWidth: maxWidth,
            );
          });

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 110,
                  child: Text(
                    label,
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),

                Expanded(
                  child: BlocBuilder<CheckOverFlowCubit, CheckOverflowState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value,
                            style: textStyle,
                            maxLines: state.expanded ? null : 1,
                            overflow:
                                state.expanded
                                    ? TextOverflow.visible
                                    : TextOverflow.ellipsis,
                          ),

                          if (state.overflow && !state.expanded)
                            GestureDetector(
                              onTap: () => cubit.expand(),
                              child: const Text(
                                'Xem thêm',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FilmInfos extends StatelessWidget {
  final FilmProduct film;

  const _FilmInfos({required this.film});

  String capitalize(String text) {
    if (text.isEmpty) {
      return text;
    }

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
    return BlocProvider(
      create: (_) => CheckOverFlowCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<CheckOverFlowCubit>();
          final textStyle = const TextStyle(color: Colors.grey, fontSize: 15);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            final maxWidth = MediaQuery.of(context).size.width;

            cubit.checkOverflow(
              value: storyLine,
              textStyle: textStyle,
              maxWidth: maxWidth,
            );
          });

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cốt truyện',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 4),

              BlocBuilder<CheckOverFlowCubit, CheckOverflowState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        storyLine,
                        style: textStyle,
                        maxLines: state.expanded ? null : 1,
                        overflow:
                            state.expanded
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                      ),

                      if (state.overflow && !state.expanded)
                        GestureDetector(
                          onTap: () => cubit.expand(),
                          child: const Text(
                            'Xem thêm',
                            style: TextStyle(color: Colors.amber, fontSize: 15),
                          ),
                        ),
                    ],
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

class _FilmDirectorOrActorInfo extends StatelessWidget {
  final String title;
  final List<Map<String, String>> people;

  const _FilmDirectorOrActorInfo({required this.title, required this.people});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),

        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
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

                      const SizedBox(height: 6),

                      SizedBox(
                        width: 60,
                        child: Text(
                          person['name']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
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
