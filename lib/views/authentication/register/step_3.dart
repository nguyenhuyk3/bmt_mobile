import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_transport_fe/bloc/register/bloc.dart';

class StepThreePage extends StatelessWidget {
  const StepThreePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_OtpInput(), SizedBox(height: 16), _NextStepButton()],
        ),
      ),
    );
  }
}

class _OtpInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentState = context.watch<RegisterBloc>().state;
    String error = '';

    if (currentState is RegisterError) error = currentState.error;

    return TextField(
      key: const Key('register_otpInput_textField'),
      onChanged:
          (otp) => {context.read<RegisterBloc>().add(RegisterOtpChanged(otp))},
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
    return ElevatedButton(
      key: const Key('signUp_nextStepnextStep_raisedButton'),
      onPressed:
          () => {context.read<RegisterBloc>().add(RegisterEmailSubmitted())},
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(const Color(0xFFF9E400)),
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
          'COncak',
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
