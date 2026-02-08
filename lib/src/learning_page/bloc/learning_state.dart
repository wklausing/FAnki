import 'package:anki_app/src/learning_page/model/flashcard.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
sealed class LearningState extends Equatable {
  const LearningState();

  @override
  List<Object?> get props => [];
}

class LearningErrorState extends LearningState {}

class LearningLoadingState extends LearningState {}

class LearningLoadedState extends LearningState {
  final List<Flashcard> cards;
  final int currentIndex;
  final bool isAnswerShown;

  const LearningLoadedState({
    required this.cards,
    required this.currentIndex,
    required this.isAnswerShown,
  });

  Flashcard get currentCard => cards[currentIndex];

  @override
  List<Object?> get props => [cards, currentIndex, isAnswerShown];

  LearningLoadedState copyWith({
    List<Flashcard>? cards,
    int? currentIndex,
    bool? isAnswerShown,
  }) {
    return LearningLoadedState(
      cards: cards ?? this.cards,
      currentIndex: currentIndex ?? this.currentIndex,
      isAnswerShown: isAnswerShown ?? this.isAnswerShown,
    );
  }
}

class LearningFinishedState extends LearningState {}
