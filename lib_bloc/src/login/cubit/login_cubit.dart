import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginCubit(this._authenticationRepository) : super(LoginInitial());

  void login(String email, String password) async {
    emit(LoginLoading());
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
          email: email, password: password);
      emit(LoginSuccess());
      print('Login successful');
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
      print('Login failed');
    }
  }

  void logout() async {
    emit(LoginLoading());
    try {
      await _authenticationRepository.logOut();
      emit(LoginInitial());
      print('Logout successful');
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
      print('Logout failed');
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
