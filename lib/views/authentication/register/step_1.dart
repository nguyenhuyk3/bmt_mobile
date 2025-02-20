import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_transport_fe/bloc/register/bloc.dart';

class StepOnePage extends StatelessWidget {
  const StepOnePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_EmailInput(), SizedBox(height: 16), _NextStepButton()],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentState = context.watch<RegisterBloc>().state;
    String error = '';

    if (currentState is RegisterError) {
      error = currentState.error;
    }

    return TextField(
      key: const Key('signUp_emailInput_textField'),
      onChanged: (email) => {},
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email_outlined),
        labelText: 'Email',
        errorText: error,
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
      onPressed: () => {},
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
          'Bước tiếp theo',
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
