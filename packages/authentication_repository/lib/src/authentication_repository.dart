import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  
  // "Stream<AuthenticationStatus>" this is a Stream that emits events of type AuthenticationStatus.
  Stream<AuthenticationStatus> get status async* {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }


  Future<void> logIn(
      {required String username, required String password}) async {
    await Future.delayed(
      const Duration(microseconds: 100),
      () => {
        _controller.add(AuthenticationStatus.authenticated),
      },
    );
  }

  Future<void> logOut() async {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
