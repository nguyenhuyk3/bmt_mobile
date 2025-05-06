import 'dart:async';

import 'package:authentication_repository/authorization_repository.export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rt_mobile/core/constants/others.dart';
import 'package:user_repository/user_repository.export.dart';

part 'event.dart';
part 'state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  AuthorizationBloc({required AuthorizationRepository authorizationRepository})
    : _authorizationRepository = authorizationRepository,
      super(const AuthorizationState.unknown()) {
    on<AuthorizationSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthorizationLogoutPressed>(_onLogoutPressed);
  }

  final AuthorizationRepository _authorizationRepository;

  FutureOr<void> _onSubscriptionRequested(
    AuthorizationSubscriptionRequested event,
    Emitter<AuthorizationState> emit,
  ) {
    return emit.onEach(
      _authorizationRepository.status,
      onData: (status) async {
        switch (status) {
          case AuthorizationStatus.unauthorized:
            return emit(const AuthorizationState.unauthorized());
          case AuthorizationStatus.authorized:
            final accessToken = await _tryGetAccessToken();

            return emit(
              accessToken != null
                  ? AuthorizationState.authorized(accessToken)
                  : const AuthorizationState.unauthorized(),
            );
          case AuthorizationStatus.unknown:
            return emit(const AuthorizationState.unknown());
        }
      },
      onError: addError,
    );
  }

  Future<String?> _tryGetAccessToken() async {
    try {
      return storage.read(ACCESS_TOKEN);
    } catch (_) {
      return null;
    }
  }

  FutureOr<void> _onLogoutPressed(
    AuthorizationLogoutPressed event,
    Emitter<AuthorizationState> emit,
  ) {
    _authorizationRepository.logOut();
  }
}
