import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:authentication_repository/authentication_repository.export.dart';
import 'package:rt_mobile/data/models/authentication/export.dart';
import 'package:rt_mobile/data/repositories/authentication.dart';

part 'event.dart';
part 'state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
    required AuthenticationRepositoryy authenticationRepositoryy,
  }) : _authenticationRepository = authenticationRepository,
       _authenticationRepositoryy = authenticationRepositoryy,
       super(const LoginState()) {
    on<LoginAccountChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;
  final AuthenticationRepositoryy _authenticationRepositoryy;

  FutureOr<void> _onUsernameChanged(
    LoginAccountChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = Email.dirty(event.email);

    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([state.password, email]),
      ),
    );
  }

  FutureOr<void> _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);

    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.email]),
      ),
    );
  }

  FutureOr<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      try {
        final response = await _authenticationRepositoryy.logIn(
          email: state.email.value,
          password: state.password.value,
        );

        switch (response.statusCode) {
          case 500:
          case 200:
        }

        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
