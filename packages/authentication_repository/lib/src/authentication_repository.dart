import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    if (username == 'w' && password == 'w') {
      await Future.delayed(
        const Duration(milliseconds: 300),
        () => _controller.add(AuthenticationStatus.authenticated),
      );

      // Can be removed, was just for testing.
      // Timer(const Duration(seconds: 10), () {
      //   _controller.add(AuthenticationStatus.unknown);
      // });
    } else {
      throw Exception('Invalid credentials');
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
