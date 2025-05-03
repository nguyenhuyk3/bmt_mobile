import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:rent_transport_fe/core/constants/error.dart';
import 'package:rent_transport_fe/data/models/authentication/export.dart';
import 'package:rent_transport_fe/core/utils/validator/validation_error_message.dart';

part 'event.dart';
part 'state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordEmailChanged>(_onForgotPasswordChanged);
    on<ForgotPasswordEmailSubmitted>(_onEmailSubmitted);
    on<ForgotPasswordOtpChanged>(_onOtpChanged);
    on<ForgotPasswordOtpSubmitted>(_onOtpSubmitted);
    on<ForgotPasswordPasswordChanged>(_onPasswordChanged);
    on<ForgotPasswordSubmitted>(_onPasswordSubmmitted);
  }

  FutureOr<void> _onForgotPasswordChanged(
    ForgotPasswordEmailChanged event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(ForgotPasswordStepOne(email: Email.dirty(event.email)));
  }

  FutureOr<void> _onEmailSubmitted(
    ForgotPasswordEmailSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    final currentState = state;

    if (currentState is ForgotPasswordStepOne) {
      if (currentState.email.value == 'huy1@gmail.com' ||
          currentState.email.value == 'huy2@gmail.com') {
        emit(ForgotPasswordError(error: 'Email không tồn tại!!'));

        return;
      }

      final error = ValidationErrorMessage.getEmailErrorMessage(
        error: currentState.email.error,
      );

      if (error != null) {
        emit(ForgotPasswordError(error: error));
      } else {
        emit(ForgotPasswordStepTwo(otp: Otp.pure()));
      }
    }
  }

  FutureOr<void> _onOtpChanged(
    ForgotPasswordOtpChanged event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(ForgotPasswordStepTwo(otp: Otp.dirty(event.otp)));
  }

  FutureOr<void> _onOtpSubmitted(
    ForgotPasswordOtpSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    final currentState = state;

    if (currentState is ForgotPasswordStepTwo) {
      if (currentState.otp.value == '123456' ||
          currentState.otp.value == '23456') {
        emit(ForgotPasswordError(error: 'Mã OTP không đúng!!'));
        return;
      }

      final error = ValidationErrorMessage.getOtpErrorMessage(
        error: currentState.otp.error,
      );

      if (error != null) {
        emit(ForgotPasswordError(error: error));

        return;
      } else {
        emit(
          ForgotPasswordStepThree(
            password: const Password.pure(),
            confirmedPassword: '',
            error: '',
          ),
        );
      }
    }
  }

  FutureOr<void> _onPasswordChanged(
    ForgotPasswordPasswordChanged event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(
      ForgotPasswordStepThree(
        password: Password.dirty(event.password),
        confirmedPassword: event.confirmedPassword,
        error: '',
      ),
    );
  }

  FutureOr<void> _onPasswordSubmmitted(
    ForgotPasswordSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    final currentState = state;

    if (currentState is ForgotPasswordStepThree) {
      final password = currentState.password;
      final error = ValidationErrorMessage.getPasswordErrorMessage(
        error: password.error,
      );

      if (error != null) {
        emit(
          ForgotPasswordStepThree(
            password: password,
            confirmedPassword: currentState.confirmedPassword,
            error: error,
          ),
        );

        return;
      }

      if (currentState.confirmedPassword.isEmpty) {
        emit(
          ForgotPasswordStepThree(
            password: password,
            confirmedPassword: currentState.confirmedPassword,
            error: EMPTY_CONFIRMED_PASSWORD_ERROR,
          ),
        );

        return;
      }

      if (currentState.password.value != currentState.confirmedPassword) {
        emit(
          ForgotPasswordStepThree(
            password: password,
            confirmedPassword: currentState.confirmedPassword,
            error: CONFIRMATION_PASSWORD_MISMATCH_ERROR,
          ),
        );
      } else {
        emit(const ForgotPasswordSuccess());
      }
    }
  }
}
