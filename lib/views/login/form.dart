import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rent_transport_fe/bloc/bloc.dart';

import '../../bloc/login/password/bloc.dart';


class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Đăng nhập thất bại'),
              ),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AccountInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _LoginButton(),
            _FacebookButton(),
          ],
        ),
      ),
    );
  }
}

class _AccountInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError =
        context.select((LoginBloc bloc) => bloc.state.account.displayError);

    return TextField(
      key: const Key('loginForm_usernameInput_textField'),
      onChanged: (username) {
        context.read<LoginBloc>().add(LoginAccountChanged(username));
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email_outlined),
        labelText: 'Tài khoản',
        errorText: displayError != null ? 'Tài khoản không hợp lệ' : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError =
        context.select((LoginBloc bloc) => bloc.state.password.displayError);

    return BlocProvider(
      create: (context) => PasswordBloc(),
      child: BlocBuilder<PasswordBloc, PasswordState>(
        builder: (context, state) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: TextField(
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) {
                context.read<LoginBloc>().add(LoginPasswordChanged(password));
              },
              obscureText: state.obscureText,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_rounded),
                suffixIcon: IconButton(
                  icon: Icon(state.obscureText
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    context
                        .read<PasswordBloc>()
                        .add(PasswordToggleVisibility());
                  },
                ),
                labelText: 'Mật khẩu',
                errorText:
                    displayError != null ? 'Mật khẩu không hợp lệ' : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgressOrSuccess = context
        .select((LoginBloc bloc) => bloc.state.status.isInProgressOrSuccess);

    if (isInProgressOrSuccess) return const CircularProgressIndicator();

    final isValid = context.select((LoginBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
      key: const Key('loginForm_continue_raisedButton'),
      onPressed: isValid
          ? () => context.read<LoginBloc>().add(const LoginSubmitted())
          : null,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(const Color(0xFFF9E400)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: const BorderSide(
              color: Colors.transparent,
              width: 1,
            ),
          ),
        ),
        minimumSize: WidgetStateProperty.all(const Size(double.infinity, 0)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(4),
        child: Text(
          'Đăng nhập',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _FacebookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('loginForm_facebook_login'),
      onPressed: () => {},
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white70),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: const BorderSide(
              color: Colors.transparent,
              width: 1,
            ),
          ),
        ),
        minimumSize: WidgetStateProperty.all(
          Size(MediaQuery.of(context).size.width * 0.4,
              MediaQuery.of(context).size.height * 0.06),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(3),
        child: Icon(
          Icons.facebook,
          color: Colors.blueAccent,
          size: 25,
        ),
      ),
    );
  }
}
