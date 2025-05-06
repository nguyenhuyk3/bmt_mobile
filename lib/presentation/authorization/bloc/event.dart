part of 'bloc.dart';

sealed class AuthorizationEvent {
  const AuthorizationEvent();
}

final class AuthorizationSubscriptionRequested extends AuthorizationEvent {}

final class AuthorizationLogoutPressed extends AuthorizationEvent {}