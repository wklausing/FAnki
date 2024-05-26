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
      emit(currentState.copyWithNewVisibility(answerIsVisible: newVisibility));
    } else {
      log.info('Wrong state 3454243 $state');
    }
  }

  void nextCard() {
    if (_cards.isNotEmpty) {
      int randomIndex = Random().nextInt(_cards.length);
      SingleCard newCard = _cards[randomIndex];
      if (state is CardLearningState) {
        final currentState = state as CardLearningState;
        List<SingleCard> updatedCards = List.from(currentState.cards);
        updatedCards.insert(0, newCard); // Insert the new card at the top
        emit(currentState.copyWithNewCard(cards: updatedCards));
        animatedListKey.currentState
            ?.insertItem(0); // Insert at the top of the AnimatedList
      }
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
        emit(CardLearningState(
            answerIsVisible: false,
            cards: _cards,
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
  final List<SingleCard> _cards;
  final GlobalKey<AnimatedListState> _animatedListKey;

  bool get answerIsVisible => _answerIsVisible;
  List<SingleCard> get cards => _cards;
  GlobalKey<AnimatedListState> get animatedListKey => _animatedListKey;

  CardLearningState({
    required bool answerIsVisible,
    required List<SingleCard> cards,
    required GlobalKey<AnimatedListState> animatedListKey,
  })  : _answerIsVisible = answerIsVisible,
        _cards = cards,
        _animatedListKey = animatedListKey;

  CardLearningState copyWithNewVisibility({required bool answerIsVisible}) {
    return CardLearningState(
      answerIsVisible: answerIsVisible,
      cards: _cards,
      animatedListKey: _animatedListKey,
    );
  }

  CardLearningState copyWithNewCard({required List<SingleCard> cards}) {
    return CardLearningState(
      answerIsVisible: false,
      cards: cards,
      animatedListKey: _animatedListKey,
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
