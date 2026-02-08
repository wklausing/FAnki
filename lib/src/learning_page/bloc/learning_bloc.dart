import 'package:anki_app/src/learning_page/bloc/learning_event.dart';
import 'package:anki_app/src/learning_page/bloc/learning_state.dart';
import 'package:anki_app/src/learning_page/model/flashcard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LearningBloc extends Bloc<LearningEvent, LearningState> {
  LearningBloc() : super(LearningLoadingState()) {
    on<StartLearning>(_onStartLearning);
    on<RevealAnswer>(_onRevealAnswer);
    on<NextCard>(_onNextCard);
  }

  Future<void> _onStartLearning(
      StartLearning event, Emitter<LearningState> emit) async {
    // Simulate loading time
    await Future.delayed(const Duration(seconds: 1));

    final exampleCards = [
      const Flashcard(question: 'Apple', answer: 'Apfel'),
      const Flashcard(question: 'Car', answer: 'Auto'),
      const Flashcard(question: 'House', answer: 'Haus'),
      const Flashcard(question: 'Dog', answer: 'Hund'),
    ];

    emit(LearningLoadedState(
      cards: exampleCards,
      currentIndex: 0,
      isAnswerShown: false,
    ));
  }

  Future<void> _onRevealAnswer(
      RevealAnswer event, Emitter<LearningState> emit) async {
    final currentState = state;
    if (currentState is LearningLoadedState) {
      emit(currentState.copyWith(isAnswerShown: true));
    }
  }

  Future<void> _onNextCard(NextCard event, Emitter<LearningState> emit) async {
    final currentState = state;
    if (currentState is LearningLoadedState) {
      if (!currentState.isFinished) {
        emit(currentState.copyWith(
          currentIndex: currentState.currentIndex + 1,
          isAnswerShown: false,
        ));
      }
    }
  }
}
