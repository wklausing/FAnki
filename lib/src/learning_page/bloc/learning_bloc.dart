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

  static const _poolCards = [
    Flashcard(question: 'Apple', answer: 'Apfel'),
    Flashcard(question: 'Car', answer: 'Auto'),
    Flashcard(question: 'House', answer: 'Haus'),
    Flashcard(question: 'Dog', answer: 'Hund'),
  ];

  Future<void> _onStartLearning(
      StartLearning event, Emitter<LearningState> emit) async {
    // Simulate loading time
    await Future.delayed(const Duration(seconds: 1));

    emit(LearningLoadedState(
      cards: [_poolCards[0]],
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
      final nextIndex = currentState.currentIndex + 1;
      final nextPoolIndex = nextIndex % _poolCards.length;
      final nextCard = _poolCards[nextPoolIndex];

      emit(currentState.copyWith(
        cards: List.from(currentState.cards)..add(nextCard),
        currentIndex: nextIndex,
        isAnswerShown: false,
      ));
    }
  }
}
