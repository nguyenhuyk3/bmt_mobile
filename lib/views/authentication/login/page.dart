import 'package:flutter/material.dart';
import 'package:rent_transport_fe/views/authentication/login/form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: const LoginForm(),
      ),
    );
  }
}
