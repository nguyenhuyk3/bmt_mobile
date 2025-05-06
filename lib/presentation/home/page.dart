import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/presentation/authorization/bloc/bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFA6F1E0),
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
      body: Center(child: _LogoutButton()),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Đăng xuất'),
      onPressed: () {
        context.read<AuthorizationBloc>().add(AuthorizationLogoutPressed());
      },
    );
  }
}

class _AccessToken extends StatelessWidget {
  const _AccessToken();

  @override
  Widget build(BuildContext context) {
    final accessToken = context.select(
      (AuthorizationBloc bloc) => bloc.state.accessToken,
    );

    return Text('Access Token: $accessToken');
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFD8F3DC),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.grey.shade300,
                child: const Icon(Icons.person, size: 30, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Text(
                'Xin chào!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
            child: Image.asset(
              'assets/illustration.png',
            ), // Hình minh họa góc phải
          ),
        ],
      ),
    );
  }
}
