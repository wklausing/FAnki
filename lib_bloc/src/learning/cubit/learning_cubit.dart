import 'package:bloc/bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:fetch_cards/fetch_cards.dart';

class LearningCubit extends Cubit<CardState> {
  String currentDeckName = '';
  String question = '';
  String answer = '';

  final CardDeckManager _cardRepository = CardDeckManager();
  List<SingleCard> cards = [];

  final AuthenticationRepository _repo;

  LearningCubit(AuthenticationRepository repo)
      : _repo = repo,
        super(CardLoadingState()) {
    loadCards();
  }

  SingleCard fetchNextCard(int i, int j) {
    var cardFoo = SingleCard(
        answerText: 'Strg', questionText: 'String', deckName: 'deckName');
    return cardFoo;
  }

  void toggleAnswerVisibility() {
    if (state is CardLearningState) {
      final currentState = state as CardLearningState;
      final newVisibility = !currentState.answerIsVisible;
      emit(currentState.copyWith(answerIsVisible: newVisibility));
    } else {
      print('Wrong state 3454243 $state');
    }
  }

  void loadCards() async {
    emit(CardLoadingState());
    try {
      cards = await _cardRepository.getAllCardsOfDeckFromFirestore();
      emit(CardLearningState(answerIsVisible: false));
    } catch (e) {
      emit(CardErrorState(e.toString()));
    }
  }
}

abstract class CardState {}

class CardLearningState extends CardState {
  final bool answerIsVisible;

  String get questionText => 'question';
  String get answerText => 'answer';

  CardLearningState({required this.answerIsVisible});

  CardLearningState copyWith({bool? answerIsVisible}) {
    return CardLearningState(
      answerIsVisible: answerIsVisible ?? this.answerIsVisible,
    );
  }
}

class CardLoadingState extends CardState {}

class CardErrorState extends CardState {
  final String error;

  CardErrorState(this.error);
}
