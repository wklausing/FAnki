import 'package:cloud_firestore/cloud_firestore.dart';

import 'main.dart';
import 'single_card.dart';

class CardDeckManager {
  final List<String> deckNames = [];
  final Map<String, List<SingleCard>> decks = {};
  String userName = 'Anna';
  String currentDeckName = 'default';
  int _index = 0;

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

  bool createDeck(String deckName) {
    bool createdDeckSuccessfully = false;
    if (deckNames.contains(deckName)) {
      log.info('Deck with name $deckName already exists.');
    } else {
      log.info('Added deck with name $deckName.');
      deckNames.add(deckName);
      createdDeckSuccessfully = true;
    }
    currentDeckName = deckName;
    return createdDeckSuccessfully;
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
    SingleCard card = SingleCard(
        deckName: currentDeckName,
        questionText: 'No cards available.',
        answerText: 'Please add some cards to the deck.');
    if (decks[currentDeckName] == null) {
      log.info('Deck is null.');
    } else if (decks[currentDeckName]!.isEmpty) {
      log.info('Deck is empty.');
    } else {
      // Ensure the index is within the range of the deck size
      _index %= decks[currentDeckName]!.length;
      card = decks[currentDeckName]![_index];
      _index++;
    }
    return card;
  }

  // ### Firestore ###
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addCardToFirestore(SingleCard card) {
    var userDoc = firestore.collection('users').doc(userName);
    var deckDoc = userDoc.collection('decks').doc(currentDeckName);
    deckDoc.collection('cards').doc(card.id).set(card.cardToMap());
  }

  void removeCardFromFirestore(SingleCard card) {
    final deckCollection =
        firestore.collection('user').doc(userName).collection(currentDeckName);
    deckCollection.doc(card.id).delete();
  }

  Future<List<SingleCard>> getAllCardsOfDeckFromFirestore() async {
    List<SingleCard> deck = [];
    var userDoc = firestore.collection('users').doc(userName);
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
    firestore
        .collection('users')
        .doc(userName)
        .set({'updatedOn': FieldValue.serverTimestamp()});
    firestore
        .collection('users')
        .doc(userName)
        .collection('decks')
        .doc(currentDeckName)
        .set({'updatedOn': FieldValue.serverTimestamp()});

    var userDoc = firestore.collection('users').doc(userName);
    var docRef = userDoc.collection('decks');

    await docRef.get().then(
      (QuerySnapshot querySnapshot) {
        log.info('inside Future');
        for (var doc in querySnapshot.docs) {
          if (doc.exists) {
            log.info(doc.id);
            deckNames.add(doc.id);
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
}
