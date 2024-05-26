import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:fetch_cards/fetch_cards.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class LearningCubit extends Cubit<CardLearnState> {
  final AuthenticationRepository _repo;
  final CardDeckManager _cdm;

  String _deckName = '';

  List<SingleCard> _cards = [];

  final GlobalKey<AnimatedListState> animatedListKey =
      GlobalKey<AnimatedListState>();

  LearningCubit(AuthenticationRepository repo, CardDeckManager cardDeckManager)
      : _repo = repo,
        _cdm = cardDeckManager,
        super(CardLoadingState()) {
    deckName = _cdm.currentDeckName;
    loadCards();
    log.info(_repo.toString());
  }

  //String get deckName => _deckName;

  set deckName(String value) {
    _deckName = value;
  }

  void toggleAnswerVisibility() {
    if (state is CardLearningState) {
      final currentState = state as CardLearningState;
      final newVisibility = !currentState._answerIsVisible;
      emit(currentState.copyWithNewVisibilty(answerIsVisible: newVisibility));
    } else {
      log.info('Wrong state 3454243 $state');
    }
  }

  void nextCard() {
    if (_cards.isNotEmpty) {
      int randomIndex = Random().nextInt(_cards.length);
      SingleCard card = _cards[randomIndex];
      final currentState = state as CardLearningState;
      emit(currentState.copyWithNewCard(card: card));
    } else {
      emit(CardEmptyState());
    }
  }

  void loadCards() async {
    emit(CardLoadingState());
    try {
      await _cdm.loadDeck();
      _cards = _cdm.getCurrentDeckCards();

      if (_cards.isEmpty) {
        emit(CardEmptyState());
      } else {
        String question = _cdm.getCurrentDeckCards().first.questionText;
        String answer = _cdm.getCurrentDeckCards().first.answerText;
        emit(CardLearningState(
            answerIsVisible: false,
            questionText: question,
            answerText: answer,
            animatedListKey: animatedListKey));
      }
    } catch (e) {
      emit(CardErrorState(e.toString()));
    }
  }

  bool answerIsVisible() {
    if (state is CardLearningState) {
      final currentState = state as CardLearningState;
      return currentState.answerIsVisible;
    } else {
      return false;
    }
  }

  void checkAndReloadDeck() {
    if (_deckName != _cdm.currentDeckName) {
      deckName = _cdm.currentDeckName;
      loadCards();
    }
  }
}

abstract class CardLearnState {}

class CardLearningState extends CardLearnState {
  final bool _answerIsVisible;
  final String _answer;
  final String _question;
  final GlobalKey<AnimatedListState> _animatedListKey;

  bool get answerIsVisible => _answerIsVisible;
  String get questionText => _question;
  String get answerText => _answer;
  GlobalKey<AnimatedListState> get animatedListKey => _animatedListKey;

  CardLearningState({
    required bool answerIsVisible,
    required String questionText,
    required String answerText,
    required GlobalKey<AnimatedListState> animatedListKey,
  })  : _answerIsVisible = answerIsVisible,
        _question = questionText,
        _answer = answerText,
        _animatedListKey = animatedListKey;

  CardLearningState copyWithNewVisibilty({required bool answerIsVisible}) {
    return CardLearningState(
      answerIsVisible: answerIsVisible,
      questionText: _question,
      answerText: _answer,
      animatedListKey: _animatedListKey,
    );
  }

  CardLearningState copyWithNewCard({required SingleCard card}) {
    return CardLearningState(
      answerIsVisible: false,
      questionText: card.questionText,
      answerText: card.answerText,
      animatedListKey: _animatedListKey,
    );
  }

  CardLearningState copyWithNewCard2(
      {required SingleCard card,
      required GlobalKey<AnimatedListState> animatedListKey}) {
    return CardLearningState(
      answerIsVisible: false,
      questionText: card.questionText,
      answerText: card.answerText,
      animatedListKey: animatedListKey,
    );
  }
}

class CardLoadingState extends CardLearnState {}

class CardEmptyState extends CardLearnState {}

class CardErrorState extends CardLearnState {
  final String error;

  CardErrorState(this.error) {
    log.info(error);
  }
}
