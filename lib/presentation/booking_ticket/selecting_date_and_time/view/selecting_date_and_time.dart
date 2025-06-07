import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectingDateAndTime extends StatelessWidget {
  SelectingDateAndTime({super.key});

  final List<String> dates = List.generate(
    14,
    (index) => DateFormat(
      'yyyy-MM-dd',
    ).format(DateTime.now().add(Duration(days: index))),
  );
  final List<String> times = ['11:05', '14:15', '16:30', '20:15'];

  @override
  Widget build(BuildContext context) {
    return (Column(
      children: [
        Text(
          "Chọn ngày và giờ",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),

        SizedBox(height: 12),

        SizedBox(
          height: 82,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            itemBuilder: (context, index) {
              return _BuildDateButton(date: dates[index]);
            },
          ),
        ),

        SizedBox(height: 12),

        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: times.length,
            itemBuilder: (context, index) {
              return _BuildTimeButton(time: times[index]);
            },
          ),
        ),
      ],
    ));
  }
}

class _BuildDateButton extends StatelessWidget {
  final String date;

  const _BuildDateButton({required this.date});

  @override
  Widget build(BuildContext context) {
    final parsedDate = DateTime.parse(date);
    final month = "T${parsedDate.month}";
    final day = DateFormat('dd').format(parsedDate);

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 45,
        padding: const EdgeInsets.symmetric(vertical: 6),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.amberAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              month,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  day,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildTimeButton extends StatelessWidget {
  final String time;

  const _BuildTimeButton({required this.time});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1400),
          border: Border.all(color: Colors.amberAccent, width: 1),
          borderRadius: BorderRadius.circular(20), // Rất bo tròn
        ),
        alignment: Alignment.center,
        child: Text(
          time,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
