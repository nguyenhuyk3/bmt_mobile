// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_transport_fe/blocs/blocs.export.dart';
import 'package:rent_transport_fe/global/error.dart';
import 'package:rent_transport_fe/views/authentication/register/register.layout.dart';

import 'step_4.dart';

class StepThreePage extends StatelessWidget {
  const StepThreePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RegisterLayout(
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
    final error = context.select<RegisterBloc, String>((bloc) {
      final state = bloc.state;

      return state is RegisterStepThree ? state.error : '';
    });

    return BlocProvider(
      create: (context) => PasswordBloc(),
      child: BlocBuilder<PasswordBloc, PasswordState>(
        builder: (context, state) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.1,
            child: TextField(
              key: const Key('register_passwordInput_textField'),
              onChanged: (password) {
                final currentState = context.read<RegisterBloc>().state;
                final confirmedPassword =
                    (currentState as RegisterStepThree?)?.confirmedPassword ??
                    '';

                context.read<RegisterBloc>().add(
                  RegisterPasswordChanged(
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
    final error = context.select<RegisterBloc, String>((bloc) {
      final currentState = bloc.state;

      return currentState is RegisterStepThree ? currentState.error : '';
    });

    return BlocProvider(
      create: (context) => PasswordBloc(),
      child: BlocBuilder<PasswordBloc, PasswordState>(
        builder: (context, state) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.1,
            child: TextField(
              key: const Key('register_confirmedPasswordInput_textField'),
              onChanged: (confirmedPassword) {
                final currentState = context.read<RegisterBloc>().state;
                final password =
                    (currentState as RegisterStepThree?)?.password.value ?? '';

                context.read<RegisterBloc>().add(
                  RegisterPasswordChanged(
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
                errorText: error.isEmpty ? null : error,
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
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterStepFour) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (_) => BlocProvider.value(
                    value: context.read<RegisterBloc>(),
                    child: StepFourPage(),
                  ),
            ),
          );
        }
      },
      child: ElevatedButton(
        key: const Key('register_nextStepThree_raisedButton'),
        onPressed:
            () => context.read<RegisterBloc>().add(RegisterPasswordSubmitted()),
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
            'Xác thực mã OTP',
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
