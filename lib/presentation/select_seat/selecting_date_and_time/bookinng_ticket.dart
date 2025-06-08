import 'package:flutter/material.dart';

class SelectSeatScreen extends StatefulWidget {
  @override
  _SelectSeatScreenState createState() => _SelectSeatScreenState();
}

class _SelectSeatScreenState extends State<SelectSeatScreen> {
  final List<String> selectedSeats = [
    'D6',
    'D7',
    'D8',
    'E5',
    'E6',
    'E11',
    'E12',
    'H7',
  ];
  final List<String> reservedSeats = ['D9', 'D10', 'E9', 'E10'];
  final List<String> availableSeats = [];

  final List<String> dates = ['07', '08', '09', '10', '11', '12', '13'];
  final List<String> times = ['11:05', '14:15', '16:30', '20:15'];

  int selectedDateIndex = 3;
  int selectedTimeIndex = 1;

  List<String> generateSeatList() {
    List<String> seats = [];
    for (var row in 'ABCDEFGHIJ'.split('')) {
      for (var i = 1; i <= 13; i++) {
        seats.add('$row$i');
      }
    }
    return seats;
  }

  Color getSeatColor(String seatId) {
    if (selectedSeats.contains(seatId)) return Colors.amber;
    if (reservedSeats.contains(seatId)) return Colors.grey;
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final seatList = generateSeatList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Select seat", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        leading: BackButton(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 40,
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber, Colors.transparent],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 13,
                childAspectRatio: 1,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: seatList.length,
              itemBuilder: (context, index) {
                final seatId = seatList[index];
                return Container(
                  decoration: BoxDecoration(
                    color: getSeatColor(seatId),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    seatId,
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLegend(Colors.black, "Available"),
                _buildLegend(Colors.grey, "Reserved"),
                _buildLegend(Colors.amber, "Selected"),
              ],
            ),
          ),
          SizedBox(height: 12),


          
          Text(
            "Select Date & Time",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dates.length,
              itemBuilder: (context, index) {
                return _buildDateButton(
                  dates[index],
                  index == selectedDateIndex,
                  () {
                    setState(() => selectedDateIndex = index);
                  },
                );
              },
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: times.length,
              itemBuilder: (context, index) {
                return _buildTimeButton(
                  times[index],
                  index == selectedTimeIndex,
                  () {
                    setState(() => selectedTimeIndex = index);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total\n210.000 VND",
                  style: TextStyle(color: Colors.white),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  onPressed: () {},
                  child: Text(
                    "But ticket",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        Container(width: 14, height: 14, color: color),
        SizedBox(width: 4),
        Text(label, style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildDateButton(String date, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        margin: EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber : Colors.black,
          borderRadius: BorderRadius.circular(25),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Dec", style: TextStyle(color: Colors.white, fontSize: 10)),
            Text(date, style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeButton(String time, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber : Colors.grey[800],
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(time, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
