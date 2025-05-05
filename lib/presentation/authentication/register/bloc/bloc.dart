// ignore_for_file: unused_field

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rt_mobile/core/constants/error.dart';
import 'package:rt_mobile/core/utils/convetors/date.dart';
import 'package:rt_mobile/data/models/models.dart';
import 'package:rt_mobile/core/utils/validator/validation_error_message.dart';
import 'package:rt_mobile/data/repositories/authentication.dart';

part 'event.dart';
part 'state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationRepositoryy authenticationRepository;
  String _email = '';
  String _password = '';

  RegisterBloc({required this.authenticationRepository})
    : super(RegisterInitial()) {
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterEmailSubmitted>(_onEmailSubmitted);
    on<RegisterOtpChanged>(_onOtpChanged);
    on<RegisterOtpSubmitted>(_onOtpSubmitted);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterPasswordSubmitted>(_onPasswordSubmitted);
    on<RegisterInformationChanged>(_onInformationChanged);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<RegisterReset>(_onRegisterReset);
  }

  Future<void> _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterStepOne(email: Email.dirty(event.email)));
  }

  FutureOr<void> _onEmailSubmitted(
    RegisterEmailSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    final currentState = state;

    if (currentState is RegisterStepOne) {
      final error = ValidationErrorMessage.getEmailErrorMessage(
        error: currentState.email.error,
      );

      if (error != null) {
        emit(RegisterError(error: error));
        return;
      }

      try {
        final response = await authenticationRepository.sendRegistrationOtp(
          email: currentState.email.value,
        );

        switch (response.statusCode) {
          case 409:
            emit(RegisterError(error: 'Email đã được đăng kí!!'));
            return;
          case 500:
            emit(
              RegisterError(error: 'Có lỗi ở phía máy chủ!!'),
            );
            return;
          case 200:
            _email = currentState.email.value;
            emit(RegisterStepTwo(otp: const Otp.pure()));
          default:
            emit(
              RegisterError(
                error: 'Lỗi không xác định (${response.statusCode ?? 'null'})',
              ),
            );
        }
      } catch (e) {
        emit(RegisterError(error: 'Không thể kết nối đến máy chủ!!'));
      }
    }
  }

  Future<void> _onOtpChanged(
    RegisterOtpChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterStepTwo(otp: Otp.dirty(event.otp)));
  }

  FutureOr<void> _onOtpSubmitted(
    RegisterOtpSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    final currentState = state;

    if (currentState is RegisterStepTwo) {
      final error = ValidationErrorMessage.getOtpErrorMessage(
        error: currentState.otp.error,
      );

      if (error != null) {
        emit(RegisterError(error: error));
        return;
      }

      try {
        final response = await authenticationRepository.verifyRegistrationOtp(
          email: _email,
          otp: currentState.otp.value,
        );

        switch (response.statusCode) {
          case 422:
            emit(RegisterError(error: 'Mã OTP không đúng!!'));
            return;
          case 200:
            emit(
              RegisterStepThree(
                password: const Password.pure(),
                confirmedPassword: '',
                error: '',
              ),
            );
          default:
            emit(
              RegisterError(
                error: 'Lỗi không xác định (${response.statusCode ?? 'null'})',
              ),
            );
        }
      } catch (e) {
        emit(RegisterError(error: 'Không thể kết nối đến máy chủ!!'));
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
            error: CONFIRMATION_PASSWORD_MISMATCH_ERROR,
          ),
        );
      } else {
        _password = currentState.password.value;
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
      if (currentState.fullName.isEmpty) {
        emit(
          RegisterStepFour(
            fullName: currentState.fullName,
            birthDate: currentState.birthDate,
            sex: currentState.sex,
            error: EMPTY_FULL_NAME_ERROR,
          ),
        );

        return;
      }
      final request = {
        'account': {'email': _email, 'password': _password},
        'info': {
          'name': currentState.fullName,
          'sex': currentState.sex,
          'birth_day': convertToDDMMYYYY(currentState.birthDate),
        },
      };
      final response = await authenticationRepository.completeRegistration(
        request: request,
      );

      switch (response.statusCode) {
        case 500:
          emit(
            RegisterStepFour(
              fullName: currentState.fullName,
              birthDate: currentState.birthDate,
              sex: currentState.sex,
              error: 'Có lỗi ở phía máy chủ!!',
            ),
          );
          return;
        case 400:
          emit(
            RegisterStepFour(
              fullName: currentState.fullName,
              birthDate: currentState.birthDate,
              sex: currentState.sex,
              error: 'Yêu cầu không hợp lệ!!',
            ),
          );
          return;
        case 200:
          emit(const RegisterSuccess());
        default:
          emit(
            RegisterError(
              error: 'Lỗi không xác định (${response.statusCode ?? 'null'})',
            ),
          );
      }
    }
  }

  FutureOr<void> _onRegisterReset(
    RegisterReset event,
    Emitter<RegisterState> emit,
  ) {
    emit(RegisterInitial());
  }
}
