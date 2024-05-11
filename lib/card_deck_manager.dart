import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:math';

import 'main.dart';
import 'single_card.dart';

class CardDeckManager {
  List<String> deckNames = [];
  final Map<String, List<SingleCard>> decks = {};
  String? userID = 'Anna';
  String currentDeckName = 'default';
  int _index = 0;

  CardDeckManager() {
    userID = FirebaseAuth.instance.currentUser!.email;
  }

  List<SingleCard>? getCurrentDeck() {
    return decks[currentDeckName];
  }

  Future<void> loadDeck() async {
    if (currentDeckIsEmpty()) {
      getAllCardsOfDeckFromFirestore();
    }
    log.info('Loading deck from database.');
  }

  List<SingleCard>? getDeck() {
    if (currentDeckIsEmpty()) {
      return [];
    } else {
      return decks[currentDeckName];
    }
  }

  void createDeck(String deckName) {
    if (deckNames.contains(deckName)) {
      log.info('Deck with name $deckName already exists.');
    } else {
      log.info('Added deck with name $deckName.');
      deckNames.add(deckName);
    }
    currentDeckName = deckName;
  }

  void addCard(SingleCard card) {
    decks[currentDeckName]!.add(card);
    addCardToFirestore(card);
  }

  void removeCard(SingleCard card) {
    decks[currentDeckName]!.remove(card);
    removeCardFromFirestore(card);
  }

  bool currentDeckIsEmpty() {
    if (decks.keys.contains(currentDeckName) &&
        decks[currentDeckName]!.isNotEmpty) {
      return false;
    }
    return true;
  }

  void setCurrentDeck(String deckName) {
    if (deckNames.contains(deckName)) {
      log.info('Deck $deckName is used now.');
      currentDeckName = deckName;
      getAllCardsOfDeckFromFirestore();
    } else {
      log.info('Deck with name $deckName does not exist.');
    }
  }

  SingleCard nextCard() {
    //Iterates over the deck endlessly in the same order.
    SingleCard card = SingleCard(
        deckName: currentDeckName,
        questionText: 'No cards available.',
        answerText: 'Please add some cards to the deck.');
    if (decks[currentDeckName] == null) {
      log.info('Deck is null.');
    } else if (decks[currentDeckName]!.isEmpty) {
      log.info('Deck is empty.');
    } else {
      _index %= decks[currentDeckName]!.length;
      card = decks[currentDeckName]![_index];
      _index++;
    }
    return card;
  }

  SingleCard nextRandomCard() {
    //Iterates over the deck endlessly in a random order.
    SingleCard card = SingleCard(
        deckName: currentDeckName,
        questionText: 'No cards available.',
        answerText: 'Please add some cards to the deck.');
    if (decks[currentDeckName] == null) {
      log.info('Deck is null.');
    } else if (decks[currentDeckName]!.isEmpty) {
      log.info('Deck is empty.');
    } else {
      _index %= decks[currentDeckName]!.length;
      card = decks[currentDeckName]![_index];
      _index++;
    }
    return card;
  }

  SingleCard nextCardWhileConsideringDifficulty(List<SingleCard> deck) {
    //Iterates over the deck endlessly in an order which considers the difficulty.
    //The higher the difficult value the higher the chance to pich that card.
    final random = Random();
    final double totalDifficultyValues =
        deck.fold(0, (sum, card) => sum + card.difficulty);
    final double rand = random.nextDouble() * totalDifficultyValues;

    double cumulativeDifficulty = 0.0;

    for (var card in deck) {
      cumulativeDifficulty += card.difficulty;
      if (cumulativeDifficulty >= rand) {
        return card;
      }
    }
    return deck.last;
  }

  // ### Firestore ###
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void createDeckInFirestore(String deckName) {
    firestore
        .collection('users')
        .doc(userID)
        .collection('decks')
        .doc(deckName)
        .set({'updatedOn': FieldValue.serverTimestamp()})
        .then((value) => log.info('Deck $deckName created.'))
        .onError((error, stackTrace) {
          log.severe('Deck $deckName could not be created. $error');
        });
  }

  void removeDeckFromFirestore(String deckName) {
    firestore
        .collection('users')
        .doc(userID)
        .collection('decks')
        .doc(deckName)
        .delete()
        .then((value) => log.info('Deck removed succesfully.'))
        .onError((error, stackTrace) {
      log.severe('Deck $deckName could not be removed.');
    });
  }

  void addCardToFirestore(SingleCard card) {
    var userDoc = firestore.collection('users').doc(userID);
    var deckDoc = userDoc.collection('decks').doc(currentDeckName);
    deckDoc.collection('cards').doc(card.id).set(card.cardToMap());
  }

  void removeCardFromFirestore(SingleCard card) {
    final deckCollection = firestore
        .collection('users')
        .doc(userID)
        .collection('decks')
        .doc(currentDeckName)
        .collection('cards');
    deckCollection.doc(card.id).delete();
  }

  Future<List<SingleCard>> getAllCardsOfDeckFromFirestore() async {
    List<SingleCard> deck = [];
    var userDoc = firestore.collection('users').doc(userID);
    var docRef =
        userDoc.collection('decks').doc(currentDeckName).collection('cards');
    await docRef.get().then(
      (QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc.exists) {
            final cardMap = doc.data() as Map<String, dynamic>;
            SingleCard card = SingleCard.fromMap(cardMap);
            deck.add(card);
          } else {
            log.info('Document does not exist');
          }
        }
      },
      onError: (e) => log.info('Error getting document: $e'),
    );
    decks[currentDeckName] = deck;
    return deck;
  }

  Future<List<String>> getAllDecknamesFromFirestore() async {
    deckNames = [];
    var userDoc = firestore.collection('users').doc(userID);
    var docRef = userDoc.collection('decks');

    await docRef.get().then(
      (QuerySnapshot querySnapshot) {
        log.info('inside Future');
        for (var doc in querySnapshot.docs) {
          if (doc.exists) {
            log.info(doc.id);
            if (!deckNames.contains(doc.id)) {
              deckNames.add(doc.id);
            }
          } else {
            log.info('Document does not exist');
          }
        }
        log.info('After for loop.');
      },
      onError: (e) => log.info('Error getting document: $e'),
    );
    return deckNames;
  }

  void updateDifficultyOfCardInFirestore(SingleCard card) {
    firestore
        .collection('users')
        .doc(userID)
        .collection('decks')
        .doc(currentDeckName)
        .collection('cards')
        .doc(card.id)
        .set(card.cardToMap())
        .then((value) => log.info('Difficulty has been updated'))
        .onError((error, stackTrace) =>
            log.severe('Update of difficulty was not successful. $error'));
  }
}