// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rt_mobile/app/export.dart';
import 'package:rt_mobile/core/constants/error.dart';
import 'package:rt_mobile/presentation/authentication/forgot_password/bloc/bloc.dart';
import 'package:rt_mobile/presentation/authentication/password/bloc/bloc.dart';
import 'package:rt_mobile/presentation/widgets/layouts/authentication/export.dart';

class StepThreeForgotPasswordPage extends StatelessWidget {
  const StepThreeForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FormScaffold(
      title: 'Quên mật khẩu',
      child: Column(
        children: [
          const SizedBox(height: 20),
          _PasswordInput(),
          _ConfirmedPasswordInput(),

          const Spacer(),

          _NextStepButton(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final error = context.select<ForgotPasswordBloc, String>((bloc) {
      final state = bloc.state;

      return state is ForgotPasswordStepThree ? state.error : '';
    });

    return BlocProvider(
      create: (context) => PasswordBloc(),
      child: BlocBuilder<PasswordBloc, PasswordState>(
        builder: (context, state) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.1,
            child: TextField(
              key: const Key('forgotPassword_passwordInput_textField'),
              onChanged: (password) {
                final currentState = context.read<ForgotPasswordBloc>().state;
                final confirmedPassword =
                    (currentState as ForgotPasswordStepThree?)
                        ?.confirmedPassword ??
                    '';

                context.read<ForgotPasswordBloc>().add(
                  ForgotPasswordPasswordChanged(
                    password: password,
                    confirmedPassword: confirmedPassword,
                  ),
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
                    (error.isEmpty ||
                            error == CONFIRMATION_PASSWORD_MISMATCH_ERROR ||
                            error == EMPTY_CONFIRMED_PASSWORD_ERROR)
                        ? null
                        : error,
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

class _ConfirmedPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final error = context.select<ForgotPasswordBloc, String>((bloc) {
      final currentState = bloc.state;

      return currentState is ForgotPasswordStepThree ? currentState.error : '';
    });

    return BlocProvider(
      create: (context) => PasswordBloc(),
      child: BlocBuilder<PasswordBloc, PasswordState>(
        builder: (context, state) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.1,
            child: TextField(
              key: const Key('forgotPassword_confirmedPasswordInput_textField'),
              onChanged: (confirmedPassword) {
                final currentState = context.read<ForgotPasswordBloc>().state;
                final password =
                    (currentState as ForgotPasswordStepThree?)
                        ?.password
                        .value ??
                    '';

                context.read<ForgotPasswordBloc>().add(
                  ForgotPasswordPasswordChanged(
                    password: password,
                    confirmedPassword: confirmedPassword,
                  ),
                );
              },
              obscureText: state.obscureText,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.check_circle_outline),
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
                labelText: 'Xác nhận mật khẩu',
                errorText:
                    (error.isEmpty || error == PASSWORD_CAN_NOT_BE_BLANK)
                        ? null
                        : error,
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

class _NextStepButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AppView()),
            (route) => false,
          );
        }
      },
      child: ElevatedButton(
        key: const Key('forgotPassword_nextStepThree_raisedButton'),
        onPressed:
            () => context.read<ForgotPasswordBloc>().add(
              ForgotPasswordSubmitted(),
            ),
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
            'Xác nhận mật khẩu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
