// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/data/models/cinema/cinema.showtime.dart';
import 'package:rt_mobile/presentation/cubit/change_tab/change_tab.dart';
import 'package:rt_mobile/presentation/film_detail/available_cinema/bloc/bloc.dart';
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
          return _AvailableCinemaContainer(cinemas: state.cinemas);
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

class _AvailableCinemaContainer extends StatelessWidget {
  final List<CinemaShowtime> cinemas;

  const _AvailableCinemaContainer({required this.cinemas});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Provide ChangeTabCubit with an initial state of ChoseCinemaState
      create:
          (_) => ChangeTabCubit<ChoseCinemaState>(
            initialState: ChoseCinemaState(),
          ),

      // Listen to ChoseCinemaState and rebuild the UI accordingly
      child: BlocBuilder<ChangeTabCubit<ChoseCinemaState>, ChoseCinemaState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 12),

              // Title for the cinema section
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
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

              const SizedBox(height: 12),

              if (cinemas.isNotEmpty)
                /*
                ✅ List.generate:
                - Dynamically generates a List of widgets based on the given length (cinemas.length).
                - Each widget is created using the function passed to it (here, a GestureDetector).

                ✅ Spread operator (...) :
                - Used to "unpack" or insert each generated widget into the parent list of children in the widget tree.
              */
                ...List.generate(cinemas.length, (index) {
                  final cinema = cinemas[index];
                  final isSelected = index == state.selectedIndex;

                  /*
                  ✅ GestureDetector:
                  - A widget used to capture touch gestures (e.g., tap, double tap, long press, drag, etc.).
                  - Here, it's used to detect when a cinema item is tapped.

                  👉 When tapped, it updates the cubit state using copyWith():
                      - selectedIndex: to highlight the selected cinema
                      - selectedCinemaId: to store the selected cinema's ID
                */
                  return GestureDetector(
                    onTap: () {
                      context
                          .read<ChangeTabCubit<ChoseCinemaState>>()
                          .changeTab(
                            state.copyWith(
                              selectedIndex: index,
                              selectedCinemaId: cinema.id,
                            ),
                          );
                    },
                    child: _BuildCinemaItem(
                      cinema: cinema,
                      isSelected: isSelected,
                    ),
                  );
                })
              else
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Phim này hiện tại không có suất chiếu',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 12),

              if (cinemas.isNotEmpty) _ConfirmationButton(),
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
          color: isSelected ? Colors.amberAccent : Colors.transparent,
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

class _ConfirmationButton extends StatelessWidget {
  const _ConfirmationButton();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amberAccent,
            foregroundColor: Colors.black,
          ),
          onPressed: () {
            // TODO: Handle confirmation logic for selected cinema
          },
          child: const Text(
            'Xác nhận chọn rạp',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
