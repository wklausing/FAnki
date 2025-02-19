part of 'authentication_bloc.dart';

class AuthenticationState {
  final AuthenticationStatus status;
  final String? user;

  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(String user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);
}
