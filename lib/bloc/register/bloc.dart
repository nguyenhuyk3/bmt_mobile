// ignore_for_file: unused_field

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rent_transport_fe/global/error.dart';
import 'package:rent_transport_fe/global/other.dart';
import 'package:rent_transport_fe/models/models.dart';
import 'package:rent_transport_fe/utils/validator/validation_error_message.dart';

part 'event.dart';
part 'state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  String _email = '';
  String _password = '';

  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterEmailSubmitted>(_onEmailSubmitted);
    on<RegisterOtpChanged>(_onOtpChanged);
    on<RegisterOtpSubmitted>(_onOtpSubmitted);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterPasswordSubmitted>(_onPasswordSubmitted);
    on<RegisterInformationChanged>(_onInformationChanged);
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterStepOne(email: Account.dirty(event.email)));
  }

  Future<void> _onEmailSubmitted(
    RegisterEmailSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    final currentState = state;

    if (currentState is RegisterStepOne) {
      if (currentState.email.value == 'huy@gmail.com' ||
          currentState.email.value == 'huy1@gmail.com') {
        emit(
          RegisterError(error: 'Email: ${currentState.email.value} đã tồn tại'),
        );

        return;
      }

      final error = ValidationErrorMessage.getAccountErrorMessage(
        error: currentState.email.error,
      );

      if (error != null) {
        emit(RegisterError(error: error));

        return;
      } else {
        emit(RegisterStepTwo(otp: const Otp.pure()));
      }
    }
  }

  Future<void> _onOtpChanged(
    RegisterOtpChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterStepTwo(otp: Otp.dirty(event.otp)));
  }

  Future<void> _onOtpSubmitted(
    RegisterOtpSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    final currentState = state;

    if (currentState is RegisterStepTwo) {
      if (currentState.otp.value == '123456' ||
          currentState.otp.value == '234567') {
        emit(
          RegisterError(error: 'Mã: ${currentState.otp.value} không hợp lệ!!'),
        );

        return;
      }

      final error = ValidationErrorMessage.getOtpErrorMessage(
        error: currentState.otp.error,
      );

      if (error != null) {
        emit(RegisterError(error: error));

        return;
      } else {
        emit(
          RegisterStepThree(
            password: const Password.pure(),
            confirmedPassword: '',
            error: '',
          ),
        );
      }
    }
  }

  Future<void> _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit(
      RegisterStepThree(
        password: Password.dirty(event.password),
        confirmedPassword: event.confirmedPassword,
        error: '',
      ),
    );
  }

  Future<void> _onPasswordSubmitted(
    RegisterPasswordSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    final currentState = state;

    if (currentState is RegisterStepThree) {
      final password = currentState.password;
      final error = ValidationErrorMessage.getPasswordErrorMessage(
        error: password.error,
      );

      if (error != null) {
        emit(
          RegisterStepThree(
            password: password,
            confirmedPassword: currentState.confirmedPassword,
            error: error,
          ),
        );

        return;
      }

      if (currentState.confirmedPassword.isEmpty) {
        emit(
          RegisterStepThree(
            password: password,
            confirmedPassword: currentState.confirmedPassword,
            error: EMPTY_CONFIRMED_PASSWORD_ERROR,
          ),
        );

        return;
      }

      if (currentState.password.value != currentState.confirmedPassword) {
        emit(
          RegisterStepThree(
            password: password,
            confirmedPassword: currentState.confirmedPassword,
            error: CONFIRMED_PASSWORD_ERR_DOES_NOT_MATCHED,
          ),
        );
      } else {
        emit(RegisterStepFour(fullName: '', birthDate: ''));
      }
    }
  }

  Future<void> _onInformationChanged(
    RegisterInformationChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit(
      RegisterStepFour(
        fullName: event.fullName,
        birthDate: event.formattedBirthDate,
        sex: event.sex,
      ),
    );
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    final currentState = state;

    if (currentState is RegisterStepFour) {
      final fullName = currentState.fullName;

      if (fullName.isEmpty) {
        emit(
          RegisterStepFour(
            fullName: fullName,
            birthDate: currentState.birthDate,
            sex: currentState.sex,
            error: EMPTY_FULL_NAME_ERROR,
          ),
        );

        return;
      }
      // final userData = {
      //   "email": _email,
      //   "password": _password,
      //   "full_name": currentState.fullName,
      //   "birth_date": currentState.birthDate,
      //   "sex": currentState.sex,
      // };
    }

    emit(const RegisterSuccess());
  }
}
