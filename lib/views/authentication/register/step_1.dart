import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_transport_fe/blocs/register/bloc.dart';
import 'package:rent_transport_fe/views/authentication/register/register.layout.dart';

import 'step_2.dart';

class StepOnePage extends StatelessWidget {
  const StepOnePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RegisterLayout(
      allowBack: true,
      child: Column(
        children: [
          const SizedBox(height: 20),
          _EmailInput(),

          const Spacer(),

          _NextStepButton(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final error = context.select<RegisterBloc, String>((bloc) {
      final state = bloc.state;

      return state is RegisterError ? state.error : '';
    });

    return TextField(
      key: const Key('register_emailInput_textField'),
      onChanged:
          (email) =>
              context.read<RegisterBloc>().add(RegisterEmailChanged(email)),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email_outlined),
        labelText: 'Email',
        errorText: error.isEmpty ? null : error,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );
  }
}

class _NextStepButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterStepTwo) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (_) => BlocProvider.value(
                    value: context.read<RegisterBloc>(),
                    child: StepTwoPage(),
                  ),
            ),
          );
        }
      },
      child: ElevatedButton(
        key: const Key('register_nextStepTwo_raisedButton'),
        onPressed:
            () => {context.read<RegisterBloc>().add(RegisterEmailSubmitted())},
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
            'Gửi mã xác thực OTP',
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
