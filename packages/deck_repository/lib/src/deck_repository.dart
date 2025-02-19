import 'dart:math';

import 'models/deck_model.dart';
import 'models/flash_card_model.dart';

class DeckRepository {
  final List<DeckModel> _decks = [];

  DeckRepository();

  List<DeckModel> getDecks() {
    DeckModel deckModel = DeckModel(deckCreator: "Name", deckName: "Zebras");
    _decks.add(deckModel);
    DeckModel deckModel2 = DeckModel(deckCreator: "Name", deckName: "Zebras2");
    _decks.add(deckModel2);
    return _decks;
  }

  void addDeck(DeckModel deck) {
    _decks.add(deck);
  }

  // Remove later
  List<FlashCardModel> getRandomMockFlashCards() {
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
