import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/data/models/cinema/cinema.showtime.dart';
import 'package:rt_mobile/presentation/film_detail/available_cinema/bloc/bloc.dart';
import 'package:rt_mobile/presentation/film_detail/available_cinema/cubit/chose_cinema.cutbit.dart';
import 'package:rt_mobile/presentation/film_detail/available_cinema/cubit/chose_cinema.state.dart';
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
          final List<CinemaShowtime> cinemaList = [
            CinemaShowtime(
              id: 1,
              name: 'Galaxy Nguyễn Du',
              city: 'Hồ Chí Minh',
              location: '116 Nguyễn Du, Quận 1',
            ),
            CinemaShowtime(
              id: 2,
              name: 'CGV Vincom Đồng Khởi',
              city: 'Hồ Chí Minh',
              location: '72 Lê Thánh Tôn, Quận 1',
            ),
            CinemaShowtime(
              id: 3,
              name: 'Lotte Cinema Cộng Hòa',
              city: 'Hồ Chí Minh',
              location: '20 Cộng Hòa, Tân Bình',
            ),
            CinemaShowtime(
              id: 4,
              name: 'BHD Star Bitexco',
              city: 'Hồ Chí Minh',
              location: '2 Hải Triều, Quận 1',
            ),
          ];

          return _AvailableCinemaContainer(cinemas: cinemaList);
        } else {
          final List<CinemaShowtime> cinemaList = [
            CinemaShowtime(
              id: 1,
              name: 'Galaxy Nguyễn Du',
              city: 'Hồ Chí Minh',
              location: '116 Nguyễn Du, Quận 1',
            ),
            CinemaShowtime(
              id: 2,
              name: 'CGV Vincom Đồng Khởi',
              city: 'Hồ Chí Minh',
              location: '72 Lê Thánh Tôn, Quận 1',
            ),
            CinemaShowtime(
              id: 3,
              name: 'Lotte Cinema Cộng Hòa',
              city: 'Hồ Chí Minh',
              location: '20 Cộng Hòa, Tân Bình',
            ),
            CinemaShowtime(
              id: 4,
              name: 'BHD Star Bitexco',
              city: 'Hồ Chí Minh',
              location: '2 Hải Triều, Quận 1',
            ),
          ];

          return _AvailableCinemaContainer(cinemas: cinemaList);
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
    return BlocProvider(
      create: (_) => ChoseCinemaCubit(),
      child: BlocBuilder<ChoseCinemaCubit, ChoseCinemaState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(height: 10),

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

              SizedBox(height: 12),

              ...List.generate(cinemas.length, (index) {
                final cinema = cinemas[index];
                final isSelected = index == state.selectedIndex;

                return GestureDetector(
                  onTap: () {
                    context.read<ChoseCinemaCubit>().choseCinema(
                      selectedIndex: index,
                      selectedCinemaId: cinema.id,
                    );
                  },
                  child: _BuildCinemaItem(
                    cinema: cinema,
                    isSelected: isSelected,
                  ),
                );
              }),

              const SizedBox(height: 16),

              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Xác nhận chọn rạp',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BuildCinemaItem extends StatelessWidget {
  final CinemaShowtime cinema;
  final bool isSelected;

  const _BuildCinemaItem({required this.cinema, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:
            isSelected
                ? Colors.amber.shade100.withOpacity(0.2)
                : Colors.grey.shade900,
        border: Border.all(
          color: isSelected ? Colors.amber : Colors.transparent,
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
