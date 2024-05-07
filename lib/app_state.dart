import 'package:anki_app/card_deck_manager.dart';
import 'package:anki_app/single_card.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  CardDeckManager cardDeckManager = CardDeckManager();
  String currentDeck = 'default';
  SingleCard card = SingleCard(
      deckName: 'deckName', questionText: 'LoadingQ', answerText: 'LoadingA');
  List<String> deckNames = [];
  int selectedDeckIndex = -1;

  AppState({String initialDeck = 'default'})
      : cardDeckManager = CardDeckManager(),
        currentDeck = initialDeck {
    cardDeckManager.setCurrentDeck(currentDeck);
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
      selectedDeckIndex = deckNames.indexOf(currentDeck);
    }
    notifyListeners();
  }

  void createDeck(String deckName) {
    cardDeckManager.currentDeckName = deckName;
    deckNames.add(deckName);
  }

  void loadCardsFromDeck() async {
    await cardDeckManager.getAllCardsOfDeckFromFirestore().then(
      (value) {
        nextCard();
      },
    );
  }

  void changeDeck(String newDeck) async {
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

  void setSelectedDeckIndex(int index) {
    selectedDeckIndex = index;
    loadCardsFromDeck();
    notifyListeners();
  }
}
