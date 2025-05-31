import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 100),
        child: CircularProgressIndicator(color: Colors.yellowAccent),
      ),
    );
  }
}
