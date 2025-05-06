import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rt_mobile/core/constants/others.dart';
import 'package:rt_mobile/core/utils/validator/validation_error_message.dart';
import 'package:rt_mobile/data/models/authentication/export.dart';
import 'package:rt_mobile/data/repositories/authentication.dart';

part 'event.dart';
part 'state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthenticationRepository authenticationRepository})
    : _authenticationRepository = authenticationRepository,
      super(const LoginState()) {
    on<LoginEmailChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  FutureOr<void> _onUsernameChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(email: Email.dirty(event.email), error: ''));
  }

  FutureOr<void> _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(password: Password.dirty(event.password), error: ''));
  }

  FutureOr<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    logger.e(state);

    final emailError = ValidationErrorMessage.getEmailErrorMessage(
      error: state.email.error,
    );

    final passwordError = ValidationErrorMessage.getPasswordErrorMessage(
      error: state.password.error,
    );
    if (emailError != null || passwordError != null) {
      emit(
        state.copyWith(
          email: state.email,
          password: state.password,
          error: emailError ?? passwordError,
        ),
      );
      return;
    }

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      final response = await _authenticationRepository.logIn(
        email: state.email.value,
        password: state.password.value,
      );

      switch (response.statusCode) {
        case 500:
          emit(state.copyWith(status: FormzSubmissionStatus.failure));
          break;
        case 200:
          emit(
            state.copyWith(
              status: FormzSubmissionStatus.success,
              error: 'Có lỗi ở phía server!!',
            ),
          );
          break;
      }
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
