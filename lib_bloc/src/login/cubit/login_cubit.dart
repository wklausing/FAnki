import 'package:bloc/bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(super.initialState);

  void fetchNextCard(int i, int j) {}

  void toggleAnswerVisibility() {
    bool newVisibility = !state.answerIsVisible;
    emit(state.copyWith(answerIsVisible: newVisibility));
  }
}

class LoginState {
  final bool answerIsVisible;

  String get questionText => 'question';
  String get answerText => 'answer';

  LoginState({required this.answerIsVisible});

  LoginState copyWith({bool? answerIsVisible}) {
    return LoginState(
      answerIsVisible: answerIsVisible ?? this.answerIsVisible,
    );
  }
}
