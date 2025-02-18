import 'dart:math';

import 'package:bloc/bloc.dart';

import '../models/flash_card_model.dart';

part 'deck_event.dart';
part 'deck_state.dart';

class DeckBloc extends Bloc<DeckEvent, DeckState> {
  final String deckId;

  DeckBloc({String? deckId})
      : deckId = deckId ?? 'mockDeck',
        super(const DeckState()) {
    on<FetchFlashCardsForDeckEvent>(_fetchCards);
  }

  Future<void> _fetchCards(
      FetchFlashCardsForDeckEvent event, Emitter<DeckState> emit) async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(Duration(seconds: 2));
    List<FlashCardModel> flashCards = generateRandomMockFlashCards();

    emit(state.copyWith(isLoading: false, flashCards: flashCards));
  }

  // Remove later
  List<FlashCardModel> generateRandomMockFlashCards() {
    int count = 10;
    final random = Random();

    // Sample flashcard data.
    // The questions and answers are aligned by index.
    final List<String> sampleQuestions = [
      "What is the capital of France?",
      "What is 2+2?",
      "Who wrote '1984'?",
      "What is the boiling point of water?",
      "Who painted the Mona Lisa?",
      "What is the largest planet in our solar system?",
      "Who discovered penicillin?",
      "What is the speed of light?",
      "What is the tallest mountain in the world?",
      "What is the formula for water?",
    ];

    final List<String> sampleAnswers = [
      "Paris",
      "4",
      "George Orwell",
      "100°C",
      "Leonardo da Vinci",
      "Jupiter",
      "Alexander Fleming",
      "300,000 km/s",
      "Mount Everest",
      "H2O",
    ];

    // List to hold our generated flashcards.
    final List<FlashCardModel> flashCards = [];

    for (int i = 0; i < count; i++) {
      // Randomly pick an index from our sample data.
      final int randomIndex = random.nextInt(sampleQuestions.length);

      flashCards.add(
        FlashCardModel(
          index: i + 1, // Flashcard numbering starts at 1
          question: sampleQuestions[randomIndex],
          answer: sampleAnswers[randomIndex],
        ),
      );
    }

    return flashCards;
  }
}
