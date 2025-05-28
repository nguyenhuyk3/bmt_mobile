import 'package:flutter/material.dart';
import 'package:rt_mobile/core/constants/others.dart';
import 'package:rt_mobile/presentation/home/widgets/movie_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 10),
            const Text(
              'Xin chào!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          color: Colors.black,
          child: ListView(
            shrinkWrap: true,
            children: [MovieCarousel(movies: movies)],
          ),
        ),
      ),
    );
  }
}
