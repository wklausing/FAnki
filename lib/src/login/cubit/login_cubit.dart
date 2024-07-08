import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:card_repository/card_deck_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authenticationRepository;
  final CardDeckManager _cdm;

  LoginCubit(this._authenticationRepository, this._cdm)
      : super(LoginLoading()) {
    if (_authenticationRepository.currentUser.isEmpty) {
      log.info('CurrentUser empty');
      emit(LoginInitial());
    } else {
      log.info('CurrentUser not empty');
      String email = _authenticationRepository.currentUser.email ?? '';
      if (email == '') {
        log.severe('Did not get the email from auth.');
        _cdm.setUserID(email);
      }
      emit(LoginSuccess());
    }
  }

  void login(String email, String password) async {
    emit(LoginLoading());
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
          email: email, password: password);
      emit(LoginSuccess());
      _cdm.setUserID(email);
      log.info('Login successful');
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
      log.info('Login failed');
    }
  }

  void logout() async {
    emit(LoginLoading());
    try {
      await _authenticationRepository.logOut();
      emit(LoginInitial());
      log.info('Logout successful');
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
      log.info('Logout failed');
    }
  }

  String userLoggedIn() {
    User currentUser = _authenticationRepository.currentUser;
    final email = currentUser.email;
    if (currentUser.isNotEmpty && email != null) {
      return email;
    } else {
      return 'false';
    }
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}
