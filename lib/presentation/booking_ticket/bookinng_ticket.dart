import 'package:flutter/material.dart';
import 'package:rt_mobile/presentation/booking_ticket/selecting_date_and_time/view/selecting_date_and_time.dart';

class SelectSeatScreen extends StatefulWidget {
  @override
  _SelectSeatScreenState createState() => _SelectSeatScreenState();
}

class _SelectSeatScreenState extends State<SelectSeatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Đăt ghế", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        leading: BackButton(color: Colors.white),
        elevation: 0,
      ),
      body: Column(children: [SelectingDateAndTime()]),
    );
  }
}
