import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:fetch_cards/fetch_cards.dart';

class LearningCubit extends Cubit<CardState> {
  String currentDeckName = '';
  String question = '';
  String answer = '';

  final CardDeckManager _cardRepository = CardDeckManager();
  List<SingleCard> cards = [];

  LearningCubit() : super(CardLoadingState(answerIsVisible: true)) {
    //loadCards();
  }

  SingleCard fetchNextCard(int i, int j) {
    return cards.first;
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
    emit(CardLoadingState(answerIsVisible: true));
    try {
      cards = await _cardRepository.getAllCardsOfDeckFromFirestore();
      // Assuming you have a way to handle the loaded cards
      emit(CardLearningState(
          answerIsVisible: false)); // Replace with appropriate logic
    } catch (e) {
      // emit(CardErrorState("Failed to fetch cards"));
      emit(CardErrorState(answerIsVisible: true));
    }
  }

  // List<SingleCard>? getDeck() {
  //   if (currentDeckIsEmpty()) {
  //     return [];
  //   } else {
  //     return decks[currentDeckName];
  //   }
  // }

  // void createDeck(String deckName) {
  //   if (deckNames.contains(deckName)) {
  //     log.info('Deck with name $deckName already exists.');
  //   } else {
  //     log.info('Added deck with name $deckName.');
  //     deckNames.add(deckName);
  //   }
  //   currentDeckName = deckName;
  // }

  // void addCard(SingleCard card) {
  //   decks[currentDeckName]!.add(card);
  //   addCardToFirestore(card);
  // }

  // void removeCard(SingleCard card) {
  //   decks[currentDeckName]!.remove(card);
  //   removeCardFromFirestore(card);
  // }

  // bool currentDeckIsEmpty() {
  //   if (decks.keys.contains(currentDeckName) &&
  //       decks[currentDeckName]!.isNotEmpty) {
  //     return false;
  //   }
  //   return true;
  // }

  // void setCurrentDeck(String deckName) {
  //   if (deckNames.contains(deckName)) {
  //     log.info('Deck $deckName is used now.');
  //     currentDeckName = deckName;
  //     getAllCardsOfDeckFromFirestore();
  //   } else {
  //     log.info('Deck with name $deckName does not exist.');
  //   }
  // }

  // SingleCard nextCard() {
  //   //Iterates over the deck endlessly in the same order.
  //   SingleCard card = SingleCard(
  //       deckName: currentDeckName,
  //       questionText: 'No cards available.',
  //       answerText: 'Please add some cards to the deck.');
  //   if (decks[currentDeckName] == null) {
  //     log.info('Deck is null.');
  //   } else if (decks[currentDeckName]!.isEmpty) {
  //     log.info('Deck is empty.');
  //   } else {
  //     _index %= decks[currentDeckName]!.length;
  //     card = decks[currentDeckName]![_index];
  //     _index++;
  //   }
  //   return card;
  // }

  // SingleCard nextRandomCard() {
  //   //Iterates over the deck endlessly in a random order.
  //   SingleCard card = SingleCard(
  //       deckName: currentDeckName,
  //       questionText: 'No cards available.',
  //       answerText: 'Please add some cards to the deck.');
  //   if (decks[currentDeckName] == null) {
  //     log.info('Deck is null.');
  //   } else if (decks[currentDeckName]!.isEmpty) {
  //     log.info('Deck is empty.');
  //   } else {
  //     _index %= decks[currentDeckName]!.length;
  //     card = decks[currentDeckName]![_index];
  //     _index++;
  //   }
  //   return card;
  // }

  // SingleCard nextCardWhileConsideringDifficulty(List<SingleCard> deck) {
  //   //Iterates over the deck endlessly in an order which considers the difficulty.
  //   //The higher the difficult value the higher the chance to pich that card.
  //   final random = Random();
  //   final double totalDifficultyValues =
  //       deck.fold(0, (sum, card) => sum + card.difficulty);
  //   final double rand = random.nextDouble() * totalDifficultyValues;

  //   double cumulativeDifficulty = 0.0;

  //   for (var card in deck) {
  //     cumulativeDifficulty += card.difficulty;
  //     if (cumulativeDifficulty >= rand) {
  //       return card;
  //     }
  //   }
  //   return deck.last;
  // }
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

class CardLoadingState extends CardState {
  final bool answerIsVisible;

  String get questionText => 'question';
  String get answerText => 'answer';

  CardLoadingState({required this.answerIsVisible});

  CardLoadingState copyWith({bool? answerIsVisible}) {
    return CardLoadingState(
      answerIsVisible: answerIsVisible ?? this.answerIsVisible,
    );
  }
}

class CardErrorState extends CardState {
  // CardErrorState(String error);
  CardErrorState({required this.answerIsVisible});

  final bool answerIsVisible;

  String get questionText => 'question';
  String get answerText => 'answer';

  CardErrorState copyWith({bool? answerIsVisible}) {
    return CardErrorState(
      answerIsVisible: answerIsVisible ?? this.answerIsVisible,
    );
  }
}
