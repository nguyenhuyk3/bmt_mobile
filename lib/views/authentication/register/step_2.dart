// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_transport_fe/bloc/bloc.export.dart';
import 'package:rent_transport_fe/global/global.dart';
import 'package:rent_transport_fe/utils/utils.export.dart';
import 'package:rent_transport_fe/views/authentication/register/register.layout.dart';

import 'step_3.dart';

class StepTwoPage extends StatelessWidget {
  const StepTwoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RegisterLayout(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 3, // 60%
                child: _OtpInput(),
              ),

              const SizedBox(width: 10),

              Expanded(
                flex: 2, // 40%
                child: _ResendOtpButton(),
              ),
            ],
          ),
          const Spacer(),

          _NextStepButton(),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _OtpInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final error = context.select<RegisterBloc, String>((bloc) {
      final state = bloc.state;
      return state is RegisterError ? state.error : '';
    });

    return TextField(
      key: const Key('register_otpInput_textField'),
      onChanged:
          (otp) => context.read<RegisterBloc>().add(RegisterOtpChanged(otp)),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email_outlined),
        labelText: 'Otp',
        errorText: error.isEmpty ? null : error,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );
  }
}

class _ResendOtpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              TimerBloc(ticker: Ticker())
                ..add(TimerStarted(duration: TIME_FOR_RESENDING_MAIL)),
      child: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          final isDisabled = state is TimerRunInProgress;
          final timeLeft = state.duration;

          return ElevatedButton(
            key: const Key('register_resendOtp_raisedButton'),
            onPressed:
                isDisabled
                    ? null
                    : () {
                      context.read<TimerBloc>().add(
                        TimerStarted(duration: TIME_FOR_RESENDING_MAIL),
                      );
                    },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                isDisabled
                    ? const Color(0xFF0D7C66).withOpacity(0.5)
                    : const Color(0xFF0D7C66),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.transparent, width: 1),
                ),
              ),
              minimumSize: WidgetStateProperty.all(
                Size(
                  double.infinity,
                  MediaQuery.of(context).size.height * 0.068,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Text(
                isDisabled ? '${timeLeft}s' : 'Gửi lại',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
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
        if (state is RegisterStepThree) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => BlocProvider.value(
                    value: context.read<RegisterBloc>(),
                    child: StepThreePage(),
                  ),
            ),
          );
        }
      },
      child: ElevatedButton(
        key: const Key('register_nextStepThree_raisedButton'),
        onPressed:
            () => context.read<RegisterBloc>().add(RegisterOtpSubmitted()),
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
