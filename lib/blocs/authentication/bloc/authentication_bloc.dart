import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';

import 'package:bloc/bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthenticationLogoutPressed>(_onLogoutPressed);
  }

  Future<void> _onSubscriptionRequested(
      AuthenticationSubscriptionRequested event,
      Emitter<AuthenticationState> emit) {
    return emit.onEach(
      _authenticationRepository.status,
      onData: (status) async {
        switch (status) {
          case AuthenticationStatus.unauthenticated:
            return emit(const AuthenticationState.unauthenticated());
          case AuthenticationStatus.authenticated:
            final user = await getUser();
            return emit(
              // ignore: unnecessary_null_comparison

              user != null
                  ? AuthenticationState.authenticated('user')
                  : const AuthenticationState.unauthenticated(),
            );
          case AuthenticationStatus.unknown:
            return emit(const AuthenticationState.unknown());
        }
      },
      onError: addError,
    );
  }

  void _onLogoutPressed(
      AuthenticationLogoutPressed event, Emitter<AuthenticationState> emit) {
    _authenticationRepository.logOut();
  }

  UserModel? getUser() {
    final user = _authenticationRepository.getUser();
    return user;
  }
}
