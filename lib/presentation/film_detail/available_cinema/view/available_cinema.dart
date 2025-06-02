import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/data/models/cinema/cinema.showtime.dart';
import 'package:rt_mobile/presentation/film_detail/available_cinema/bloc/bloc.dart';
import 'package:rt_mobile/presentation/splash/spash_view.dart';

class AvaibleCinema extends StatelessWidget {
  const AvaibleCinema({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailableCinemaBloc, AvailableCinemaState>(
      builder: (context, state) {
        if (state is AvailableCinemaLoading) {
          return SplashPage();
        } else if (state is AvailableCinemaLoadSuccess) {
          return _AvailableCinemaContainer(cinemas: state.cinemas);
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

class _AvailableCinemaContainer extends StatelessWidget {
  final List<CinemaShowtime> cinemas;

  const _AvailableCinemaContainer({required this.cinemas});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Rạp chiếu phim',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          ...cinemas.map((cinema) => _BuildCinemaItem(cinema: cinema)).toList(),
        ],
      ),
    );
  }
}

class _BuildCinemaItem extends StatelessWidget {
  final CinemaShowtime cinema;

  const _BuildCinemaItem({required this.cinema});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:
            true
                ? Colors.amber.shade100.withOpacity(0.2)
                : Colors.grey.shade900,
        border: Border.all(
          color: true ? Colors.amber : Colors.transparent,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cinema.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            cinema.location,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
