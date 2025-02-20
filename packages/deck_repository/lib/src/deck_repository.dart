import 'dart:math';

import 'models/deck_model.dart';
import 'models/flash_card_model.dart';

class DeckRepository {
  final List<DeckModel> _decks = [];
  DeckModel? _selectedDeck;

  List<DeckModel> getDecks() {
    DeckModel deckModel = DeckModel(deckCreator: "Name", deckName: "Zebras", flashCards: []);
    _decks.add(deckModel);
    DeckModel deckModel2 = DeckModel(deckCreator: "Name", deckName: "Zebras2", flashCards: []);
    _decks.add(deckModel2);
    return _decks;
  }

  void addDeck(DeckModel deck) {
    _decks.add(deck);
  }

  bool isDeckNameUsed(String deckName) {
    for (DeckModel deck in _decks) {
      if (deck.deckName == deckName) {
        return true;
      }
    }
    return false;
  }

  void setSelectedDeck(String deckName) {
    _selectedDeck = null;
    for (DeckModel deck in _decks) {
      if (deck.deckName == deckName) {
        _selectedDeck = deck;
        return;
      }
    }
    if (_selectedDeck == null) {
      throw Exception('Unknown Deck');
    }
  }

  void addFlashCard({required String question, required String answer}) {
    if (_selectedDeck != null) {
      FlashCardModel flashCard = FlashCardModel(question: question, answer: answer);
      _selectedDeck!.flashCards.add(flashCard);
    } else {
      throw Exception('No deck selected');
    }
  }

  List<FlashCardModel> getFlashCardsFromSelectedDeck() {
    if (_selectedDeck != null) {
      return _selectedDeck!.flashCards;
    } else {
      throw Exception('No deck selected');
    }
  }

  DeckModel getSelectedDeck() {
    if (_selectedDeck != null) {
      return _selectedDeck!;
    } else {
      throw Exception('No deck selected');
    }
  }
}
