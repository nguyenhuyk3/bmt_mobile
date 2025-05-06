import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rt_mobile/data/repositories/authentication.dart';
import 'package:rt_mobile/presentation/authentication/login/bloc/bloc.dart';
import 'package:rt_mobile/presentation/authentication/login/view/form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => LoginBloc(
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
      child: Scaffold(
        backgroundColor: const Color(0xFFFBFBFB),
        resizeToAvoidBottomInset: false,
        appBar: _AppBar(),
        body: const Padding(padding: EdgeInsets.all(12), child: LoginForm()),
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
      automaticallyImplyLeading: false,
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
