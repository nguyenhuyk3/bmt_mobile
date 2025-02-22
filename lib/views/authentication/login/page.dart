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
      backgroundColor: Color(0xFFFBFBFB),
      // Prevent UI from being pushed up
      // I got this when I clicked on the password input
      resizeToAvoidBottomInset: false,
      appBar: _AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: const LoginForm(),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Đăng nhập',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 21,
          fontWeight: FontWeight.w400,
        ),
      ),
      centerTitle: true,
      elevation: 0.7,
      shadowColor: Color(0xFFEFF3EA),
      backgroundColor: Color(0xFFFBFBFB),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(0.1),
        child: Divider(height: 0.1, thickness: 0.1, color: Colors.grey),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
