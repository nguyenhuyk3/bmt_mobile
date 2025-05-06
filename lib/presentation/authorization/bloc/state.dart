part of 'bloc.dart';

class AuthorizationState extends Equatable {
  final AuthorizationStatus status;
  final String accessToken;

  // private constructor
  const AuthorizationState._({
    this.status = AuthorizationStatus.unknown,
    this.accessToken = '',
  });

  const AuthorizationState.unknown() : this._();

  const AuthorizationState.authorized(String accessToken)
    : this._(status: AuthorizationStatus.authorized, accessToken: accessToken);

  const AuthorizationState.unauthorized()
    : this._(status: AuthorizationStatus.unauthorized);

  @override
  List<Object?> get props => [status];
}
