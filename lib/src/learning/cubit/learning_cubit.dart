import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:fetch_cards/fetch_cards.dart';

class LearningCubit extends Cubit<CardLearnState> {
  final AuthenticationRepository _repo;
  final CardDeckManager _cardRepository;

  String deckName = '';
  List<SingleCard> _cards = [];

  LearningCubit(AuthenticationRepository repo, CardDeckManager cardDeckManager)
      : _repo = repo,
        _cardRepository = cardDeckManager,
        super(CardLoadingState()) {
    deckName = _cardRepository.currentDeckName;
    loadCards();
    print(_repo.toString());
  }

  void toggleAnswerVisibility() {
    if (state is CardLearningState) {
      final currentState = state as CardLearningState;
      final newVisibility = !currentState._answerIsVisible;
      emit(currentState.copyWithNewVisibilty(answerIsVisible: newVisibility));
    } else {
      print('Wrong state 3454243 $state');
    }
  }

  void loadCards() async {
    emit(CardLoadingState());
    try {
      await _cardRepository.loadDeck();
      _cards = _cardRepository.getCurrentDeck();

      if (_cards.isEmpty) {
        emit(CardEmptyState());
      } else {
        String question = _cardRepository.getCurrentDeck().first.questionText;
        String answer = _cardRepository.getCurrentDeck().first.answerText;
        emit(CardLearningState(
            answerIsVisible: false,
            questionText: question,
            answerText: answer));
      }
    } catch (e) {
      emit(CardErrorState(e.toString()));
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

  bool answerIsVisible() {
    if (state is CardLearningState) {
      final currentState = state as CardLearningState;
      return currentState.answerIsVisible;
    } else {
      return false;
    }
  }

  void checkAndReloadDeck() {
    if (deckName != _cardRepository.currentDeckName) {
      deckName = _cardRepository.currentDeckName;
      loadCards();
    }
  }
}

abstract class CardLearnState {}

class CardLearningState extends CardLearnState {
  final bool _answerIsVisible;
  final String _answer;
  final String _question;

  bool get answerIsVisible => _answerIsVisible;
  String get questionText => _question;
  String get answerText => _answer;

  CardLearningState(
      {required bool answerIsVisible,
      required String questionText,
      required String answerText})
      : _answerIsVisible = answerIsVisible,
        _question = questionText,
        _answer = answerText;

  CardLearningState copyWithNewVisibilty({required bool answerIsVisible}) {
    return CardLearningState(
      answerIsVisible: answerIsVisible,
      questionText: _question,
      answerText: _answer,
    );
  }

  CardLearningState copyWithNewCard({required SingleCard card}) {
    return CardLearningState(
      answerIsVisible: false,
      questionText: card.questionText,
      answerText: card.answerText,
    );
  }
}

class CardLoadingState extends CardLearnState {}

class CardEmptyState extends CardLearnState {}

class CardErrorState extends CardLearnState {
  final String error;

  CardErrorState(this.error) {
    print(error);
  }
}
