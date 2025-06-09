import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/core/constants/others.dart';
import 'package:rt_mobile/data/models/showtime/seat.showtime.dart';
import 'package:rt_mobile/presentation/select_seat/seats/bloc/bloc.dart';
import 'package:rt_mobile/presentation/splash/spash_view.dart';

class Seats extends StatelessWidget {
  const Seats({super.key});

  final double seatSize = 36;
  final double seatSpacing = 3;

  Color getSeatColor(String status) {
    switch (status) {
      case 'booked':
        return Colors.grey;
      case 'reserved':
        return Colors.grey.shade700;
      case 'available':
        return const Color(0xFF1E1E1E);
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeatsBloc, SeatsState>(
      builder: (context, state) {
        if (state is SeatsLoading) {
          return SplashPage();
        } else if (state is SeatsLoadSuccess) {
          return Column(
            children: [
              Container(
                height: 40,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.amber, Colors.transparent],
                  ),
                ),
              ),

              // Ghế
              SizedBox(
                width: double.infinity,
                height: 360,
                child: SingleChildScrollView(
                  child: Center(
                    child: SeatRows(
                      seats: state.seats,
                      selectedSeatIds: state.selectedSeatIds,
                      seatSize: seatSize,
                      seatSpacing: seatSpacing,
                      getSeatColor: getSeatColor,
                    ),
                  ),
                ),
              ),

              // Chú thích màu
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SeatLegend(color: const Color(0xFF1E1E1E), label: "Có sẵn"),
                    SeatLegend(color: Colors.grey, label: "Đã được đặt"),
                    SeatLegend(color: Colors.amber, label: "Đã chọn"),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Center(
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

class SeatRows extends StatelessWidget {
  final List<SeatShowtime> seats;
  final Set<int> selectedSeatIds;
  final double seatSize;
  final double seatSpacing;
  final Color Function(String) getSeatColor;

  const SeatRows({
    super.key,
    required this.seats,
    required this.selectedSeatIds,
    required this.seatSize,
    required this.seatSpacing,
    required this.getSeatColor,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: seatSpacing,
      runSpacing: seatSpacing,
      children: _buildSeatRows(context),
    );
  }

  List<Widget> _buildSeatRows(BuildContext context) {
    final List<Widget> rows = [];
    final pairedIds = <int>{};

    List<Widget> currentRow = [];
    double currentSlots = 0; // 1 for standard, 2 for coupled

    for (final seat in seats) {
      if (pairedIds.contains(seat.seatId)) {
        continue;
      }

      if (seat.seatType == 'coupled' && seat.seatId % 2 == 1) {
        // Coupled seat chiếm 2 slot
        if (currentSlots + 2 > 10) {
          rows.add(
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Căn giữa ghế trong hàng
              children: currentRow,
            ),
          );
          currentRow = [];
          currentSlots = 0;
        }

        final pair = seats.firstWhere(
          (s) => s.seatId == seat.seatId + 1,
          orElse: () => seat,
        );
        pairedIds.add(pair.seatId);

        currentRow.add(
          GestureDetector(
            onTap: () {
              if (seat.status == 'available') {
                context.read<SeatsBloc>().add(SeatsToggled(seat.seatId));
              }
            },
            child: Container(
              width: seatSize * 2 + seatSpacing,
              height: seatSize,
              margin: EdgeInsets.only(right: seatSpacing),
              decoration: BoxDecoration(
                color:
                    selectedSeatIds.contains(seat.seatId)
                        ? Colors.amber
                        : getSeatColor(seat.status),
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: Text(
                '${seat.seatNumber}  -  ${pair.seatNumber}',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        );

        currentSlots += 2;
      } else if (seat.seatType != 'coupled') {
        // Ghế thường chiếm 1 slot
        if (currentSlots + 1 > 10) {
          rows.add(
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Căn giữa ghế trong hàng
              children: currentRow,
            ),
          );
          currentRow = [];
          currentSlots = 0;
        }

        currentRow.add(
          GestureDetector(
            onTap: () {
              if (seat.status == 'available') {
                logger.i(seat.status);
                context.read<SeatsBloc>().add(SeatsToggled(seat.seatId));
              }
            },
            child: Container(
              width: seatSize,
              height: seatSize,
              margin: EdgeInsets.only(right: seatSpacing),
              decoration: BoxDecoration(
                color:
                    selectedSeatIds.contains(seat.seatId)
                        ? Colors.amber
                        : getSeatColor(seat.status),
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: Text(
                seat.seatNumber,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        );

        currentSlots += 1;
      }
    }

    // Add row còn dư
    if (currentRow.isNotEmpty) {
      rows.add(
        Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Căn giữa ghế trong hàng
          children: currentRow,
        ),
      );
    }

    return rows;
  }
}

class SeatLegend extends StatelessWidget {
  final Color color;
  final String label;

  const SeatLegend({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 14, height: 14, color: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
