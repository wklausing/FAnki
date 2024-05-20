import 'package:bloc/bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:fetch_cards/fetch_cards.dart';

class LearningCubit extends Cubit<CardState> {
  final AuthenticationRepository _repo;
  final CardDeckManager _cardRepository = CardDeckManager();
  List<SingleCard> cards = [];

  LearningCubit(AuthenticationRepository repo)
      : _repo = repo,
        super(CardLoadingState()) {
    loadCards();
    print(_repo.toString());
  }

  void toggleAnswerVisibility() {
    if (state is CardLearningState) {
      final currentState = state as CardLearningState;
      final newVisibility = !currentState._answerIsVisible;
      emit(currentState.copyWith(answerIsVisible: newVisibility));
    } else {
      print('Wrong state 3454243 $state');
    }
  }

  void loadCards() async {
    emit(CardLoadingState());
    try {
      await _cardRepository.loadDeck();
      String question = _cardRepository.getCurrentDeck().first.questionText;
      String answer = _cardRepository.getCurrentDeck().first.answerText;
      cards = await _cardRepository.getAllCardsOfDeckFromFirestore();
      emit(CardLearningState(
          answerIsVisible: false, questionText: question, answerText: answer));
    } catch (e) {
      emit(CardErrorState(e.toString()));
    }
  }

  void fetchNextCard(int i, int j) {
    String question = _cardRepository.getCurrentDeck().first.questionText;
    String answer = _cardRepository.getCurrentDeck().first.answerText;
    emit(CardLearningState(
        answerIsVisible: false, questionText: question, answerText: answer));
  }

  bool answerIsVisible() {
    if (state is CardLearningState) {
      final currentState = state as CardLearningState;
      return currentState.answerIsVisible;
    } else {
      return false;
    }
  }
}

abstract class CardState {}

class CardLearningState extends CardState {
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
        _answer = questionText,
        _question = questionText;

  CardLearningState copyWith({required bool answerIsVisible}) {
    return CardLearningState(
      answerIsVisible: answerIsVisible,
      questionText: _question,
      answerText: _answer,
    );
  }
}

class CardLoadingState extends CardState {}

class CardErrorState extends CardState {
  final String error;

  CardErrorState(this.error);
}
