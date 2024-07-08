import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/single_card.dart';

class FirebaseApi {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> getLastDeckFromFireStore(String userID) async {
    try {
      DocumentSnapshot doc =
          await firestore.collection('users').doc(userID).get();
      return doc['lastDeck'] as String;
    } catch (e) {
      print('Error getting lastDeck: $e');
      return '';
    }
  }

  void setLastDeckInFireStore(String userID, String lastDeck) {
    firestore.collection('users').doc(userID).set({'lastDeck': lastDeck});
  }

  void createDeckInFirestore(String userID, String deckName) {
    firestore
        .collection('users')
        .doc(userID)
        .collection('decks')
        .doc(deckName)
        .set({'updatedOn': FieldValue.serverTimestamp()})
        .then((value) => print('Deck $deckName created.'))
        .onError((error, stackTrace) {
          print('Deck $deckName could not be created. $error');
        });
  }

  void removeDeckFromFirestore(String userID, String deckName) {
    firestore
        .collection('users')
        .doc(userID)
        .collection('decks')
        .doc(deckName)
        .collection('cards')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    }).onError((error, stackTrace) => null);

    firestore
        .collection('users')
        .doc(userID)
        .collection('decks')
        .doc(deckName)
        .delete()
        .then((value) => print('Deck removed succesfully.'))
        .onError((error, stackTrace) {
      print('Deck $deckName could not be removed.');
    });
  }

  void addCardToFirestore(
      String userID, String currentDeckName, SingleCard card) {
    var userDoc = firestore.collection('users').doc(userID);
    var deckDoc = userDoc.collection('decks').doc(currentDeckName);
    deckDoc.collection('cards').doc(card.id).set(card.cardToMap());
  }

  void addCardToFirestoreWithoutSingleCard(
      String userID, String currentDeckName, String question, String answer) {
    SingleCard sc = SingleCard(
        deckName: currentDeckName, questionText: question, answerText: answer);
    var userDoc = firestore.collection('users').doc(userID);
    var deckDoc = userDoc.collection('decks').doc(currentDeckName);
    deckDoc.collection('cards').doc(sc.id).set(sc.cardToMap());
  }

  void removeCardFromFirestore(
      String userID, String currentDeckName, SingleCard card) {
    final deckCollection = firestore
        .collection('users')
        .doc(userID)
        .collection('decks')
        .doc(currentDeckName)
        .collection('cards');
    deckCollection.doc(card.id).delete();
  }

  void removeCardFromFirestoreByID(
      String userID, String currentDeckName, String id) {
    final deckCollection = firestore
        .collection('users')
        .doc(userID)
        .collection('decks')
        .doc(currentDeckName)
        .collection('cards');
    deckCollection.doc(id).delete();
  }

  Future<List<SingleCard>> getAllCardsOfDeckFromFirestore(
      String userID, String deckName) async {
    List<SingleCard> deck = [];
    var userDoc = firestore.collection('users').doc(userID);
    var docRef = userDoc.collection('decks').doc(deckName).collection('cards');
    await docRef.get().then(
      (QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc.exists) {
            final cardMap = doc.data() as Map<String, dynamic>;
            SingleCard card = SingleCard.fromMap(cardMap);
            deck.add(card);
          } else {
            print('Document does not exist');
          }
        }
      },
      onError: (e) => print('Error getting document: $e'),
    );
    print('Ending of getAllCardsOfDeckFromFirestore');
    return deck;
  }

  Future<List<SingleCard>> getAllCardsOfDeckFromFirestoreAndListen(
      String userID, String currentDeckName) async {
    List<SingleCard> deck = [];

    var userDoc = firestore.collection('users').doc(userID);
    var docRef =
        userDoc.collection('decks').doc(currentDeckName).collection('cards');

    docRef.snapshots().listen((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        SingleCard sc = SingleCard.fromMap(doc as Map<String, dynamic>);
        deck.add(sc);
      }
    });
    return deck;
  }

  Future<List<String>> getAllDecknamesFromFirestore(String userID) async {
    List<String> deckNames = [];
    var userDoc = firestore.collection('users').doc(userID);
    var docRef = userDoc.collection('decks');

    await docRef.get().then(
      (QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc.exists) {
            if (!deckNames.contains(doc.id)) {
              deckNames.add(doc.id);
            }
          } else {
            print('Document does not exist');
          }
        }
      },
      onError: (e) => print('Error getting document: $e'),
    );
    return deckNames;
  }

  void updateDifficultyOfCardInFirestore(
      String userID, String currentDeckName, SingleCard card) {
    firestore
        .collection('users')
        .doc(userID)
        .collection('decks')
        .doc(currentDeckName)
        .collection('cards')
        .doc(card.id)
        .set(card.cardToMap())
        .then((value) => print('Difficulty has been updated'))
        .onError((error, stackTrace) =>
            print('Update of difficulty was not successful. $error'));
  }
}
