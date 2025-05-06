import 'dart:async';

enum AuthorizationStatus { unknown, authorized, unauthorized }

class AuthorizationRepository {
  final _controller = StreamController<AuthorizationStatus>();

  // "Stream<AuthorityStatus>" this is a Stream that emits events of type AuthorizationStatus
  Stream<AuthorizationStatus> get status async* {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    yield AuthorizationStatus.unauthorized;
    yield* _controller.stream;
  }

  Future<void> logIn({required String email, required String password}) async {
    await Future.delayed(
      const Duration(microseconds: 100),
      () => {
        _controller.add(AuthorizationStatus.authorized),
      },
    );
  }

  Future<void> logOut() async {
    _controller.add(AuthorizationStatus.unauthorized);
  }

  void dispose() => _controller.close();
}
