import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:rt_mobile/core/utils/validator/validation_error_message.dart';
import 'package:rt_mobile/presentations/authentication/forgot_password/view/export.dart';
import 'package:rt_mobile/presentations/authentication/login/bloc/bloc.dart';
import 'package:rt_mobile/presentations/authentication/password/bloc/bloc.dart';
import 'package:rt_mobile/presentations/authentication/register/view/export.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('Đăng nhập thất bại')));
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Information fields
          const SizedBox(height: 20),
          _AccountInput(),
          const SizedBox(height: 20),
          _PasswordInput(),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [_ForgotPasswordButton()],
          ),

          const Divider(thickness: 0.5, color: Colors.grey),

          // Other login methods
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_FacebookLoginButton(), _GoogleLoginButton()],
          ),

          const SizedBox(height: 18),
          _RegisterButton(),

          Spacer(),

          _LoginButton(),
        ],
      ),
    );
  }
}

class _AccountInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final email = context.select((LoginBloc bloc) => bloc.state.email);

    return TextField(
      key: const Key('loginForm_accountInput_textField'),
      onChanged: (email) {
        context.read<LoginBloc>().add(LoginAccountChanged(email: email));
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email_outlined),
        labelText: 'Tài khoản',
        errorText:
            email.isPure
                ? null
                : ValidationErrorMessage.getEmailErrorMessage(
                  error: email.error,
                ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final password = context.select((LoginBloc bloc) => bloc.state.password);

    return BlocProvider(
      create: (context) => PasswordBloc(),
      child: BlocBuilder<PasswordBloc, PasswordState>(
        builder: (context, state) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: TextField(
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) {
                context.read<LoginBloc>().add(
                  LoginPasswordChanged(password: password),
                );
              },
              obscureText: state.obscureText,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_rounded),
                suffixIcon: IconButton(
                  icon: Icon(
                    state.obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    context.read<PasswordBloc>().add(
                      PasswordToggleVisibility(),
                    );
                  },
                ),
                labelText: 'Mật khẩu',
                errorText:
                    password.isPure
                        ? null
                        : ValidationErrorMessage.getPasswordErrorMessage(
                          error: password.error,
                        ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StepOneForgotPasswordPage()),
        );
      },
      child: const Text(
        'Quên mật khẩu?',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Bạn chưa là thành viên?',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StepOnePage()),
            );
          },
          child: const Text(
            'Hãy đăng ký',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final isInProgressOrSuccess = context.select(
    //   (LoginBloc bloc) => bloc.state.status.isInProgressOrSuccess,
    // );

    // if (isInProgressOrSuccess) return const CircularProgressIndicator();

    final isValid = context.select((LoginBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
      key: const Key('loginForm_continue_raisedButton'),
      onPressed:
          isValid
              ? () => context.read<LoginBloc>().add(const LoginSubmitted())
              : null,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(const Color(0xFF0D7C66)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: const BorderSide(color: Colors.transparent, width: 1),
          ),
        ),
        minimumSize: WidgetStateProperty.all(
          Size(double.infinity, MediaQuery.of(context).size.height * 0.06),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(4),
        child: Text(
          'Đăng nhập',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _FacebookLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('loginForm_facebook_login'),
      onPressed: () => {},
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Color(0xFFFBFBFB)),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(0),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: const BorderSide(color: Color(0xFFBCCCDC), width: 1),
          ),
        ),
        minimumSize: WidgetStateProperty.all(
          Size(
            MediaQuery.of(context).size.width * 0.455,
            MediaQuery.of(context).size.height * 0.05,
          ),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(3),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.facebook, color: Colors.blueAccent, size: 25),
            SizedBox(width: 12.0),
            Text(
              'Facebook',
              style: TextStyle(color: Colors.black87, fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('loginForm_google_login'),
      onPressed: () => {},
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white70),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(0),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: const BorderSide(color: Color(0xFFBCCCDC), width: 1),
          ),
        ),
        minimumSize: WidgetStateProperty.all(
          Size(
            MediaQuery.of(context).size.width * 0.45,
            MediaQuery.of(context).size.height * 0.05,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(3),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/icons/google_logo.svg', height: 24.0),
            SizedBox(width: 12.0),
            Text(
              'Google',
              style: TextStyle(color: Colors.black87, fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
