import 'package:anki_app/src/card_deck_manager.dart';
import 'package:anki_app/src/local_storage_settings.dart';
import 'package:anki_app/src/single_card.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  LocalStorageSettingsPersistence foo = LocalStorageSettingsPersistence();
  CardDeckManager cardDeckManager = CardDeckManager();
  SingleCard card = SingleCard(
      deckName: 'deckName',
      questionText: 'Loading Question',
      answerText: 'Loading Answer');
  List<String> deckNames = [];
  int selectedDeckIndex = -1;

  AppState() {
    initializeAsync();
  }

  Future<void> initializeAsync() async {
    await loadDecknames();

    String deckName = await foo.getCurrentDeck();
    changeDeck(deckName);
  }

  Future<void> loadDecknames() async {
    await cardDeckManager.getAllDecknamesFromFirestore().then(
      (value) {
        deckNames = value;
      },
    );
    if (selectedDeckIndex == -1) {
      selectedDeckIndex = deckNames.indexOf(cardDeckManager.currentDeckName);
    }
    notifyListeners();
  }

  void createDeck(String deckName) {
    if (!deckNames.contains(deckName)) {
      cardDeckManager.createDeckInFirestore(deckName);
      cardDeckManager.currentDeckName = deckName;
      loadDecknames();
      loadCardsFromDeck();
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
    foo.setCurrentDeck(newDeck);
    cardDeckManager.setCurrentDeck(newDeck);
    int index = cardDeckManager.deckNames.indexOf(newDeck);
    setSelectedDeckIndex(index);
    loadCardsFromDeck();
    notifyListeners();
  }

  void setSelectedDeckIndex(int index) {
    selectedDeckIndex = index;
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

  void newCard() {
    if (cardDeckManager.decks[cardDeckManager.currentDeckName]!.isEmpty) {
      card = cardDeckManager.nextCard();
    }
    notifyListeners();
  }

  void nextRandomCard() {
    card = cardDeckManager.nextCardWhileConsideringDifficulty(
        cardDeckManager.decks[cardDeckManager.currentDeckName]!);
    notifyListeners();
  }
}
