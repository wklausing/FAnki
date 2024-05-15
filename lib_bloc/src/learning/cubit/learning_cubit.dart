import 'package:bloc/bloc.dart';

class LearningCubit extends Cubit<LearningState> {
  LearningCubit(super.initialState);

  void fetchNextCard(int i, int j) {}

  void toggleAnswerVisibility() {
    bool newVisibility = !state.answerIsVisible;
    emit(state.copyWith(answerIsVisible: newVisibility));
  }
}

class LearningState {
  final bool answerIsVisible;

  String get questionText => 'question';
  String get answerText => 'answer';

  LearningState({required this.answerIsVisible});

  LearningState copyWith({bool? answerIsVisible}) {
    return LearningState(
      answerIsVisible: answerIsVisible ?? this.answerIsVisible,
    );
  }
}
