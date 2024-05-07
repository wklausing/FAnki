import 'package:anki_app/card_deck_manager.dart';
import 'package:anki_app/single_card.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  CardDeckManager cardDeckManager;
  SingleCard card = SingleCard(
      deckName: 'deckName', questionText: 'LoadingQ', answerText: 'LoadingA');
  List<String> deckNames = [];
  int selectedDeckIndex = -1;

  AppState({String initialDeck = 'default'})
      : cardDeckManager = CardDeckManager() {
    cardDeckManager.setCurrentDeck(initialDeck);
    loadDecknames();

    loadCardsFromDeck();
  }

  void loadDecknames() async {
    await cardDeckManager.getAllDecknamesFromFirestore().then(
      (value) {
        deckNames = value;
      },
    );
    deckNames = cardDeckManager.deckNames;
    if (selectedDeckIndex == -1) {
      selectedDeckIndex = deckNames.indexOf(cardDeckManager.currentDeckName);
    }
    notifyListeners();
  }

  void createDeck(String deckName) {
    if (!deckNames.contains(deckName)) {
      cardDeckManager.createDeckInFirestore(deckName);
      cardDeckManager.currentDeckName = deckName;
      deckNames.add(deckName);
    }
  }

  void loadCardsFromDeck() async {
    await cardDeckManager.getAllCardsOfDeckFromFirestore().then(
      (value) {
        nextCard();
      },
    );
    notifyListeners();
  }

  void changeDeck(String newDeck) {
    cardDeckManager.setCurrentDeck(newDeck);
    loadCardsFromDeck();
    notifyListeners();
  }

  void addCard(SingleCard card) {
    cardDeckManager.addCard(card);
    notifyListeners();
  }

  void removeCard(SingleCard card) {
    cardDeckManager.removeCard(card);
    notifyListeners();
  }

  void nextCard() {
    card = cardDeckManager.nextCard();
    notifyListeners();
  }

  void nextRandomCard() {
    card = cardDeckManager.nextCardWhileConsideringDifficulty(
        cardDeckManager.decks[cardDeckManager.currentDeckName]!);
    notifyListeners();
  }

  void setSelectedDeckIndex(int index) {
    selectedDeckIndex = index;
    loadCardsFromDeck();
    notifyListeners();
  }
}
