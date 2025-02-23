import 'package:deck_repository/src/data_models/deck_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'data_models/flash_card_model.dart';
import 'isar_data_models/isar_deck_model.dart';

class DeckRepository {
  late final Isar isar;

  final List<IsarDeckModel> _decks = [];
  DeckModel? _currentDeck;
  FlashCardModel? _currentFlashCard;

  DeckRepository._create(this.isar);

  static Future<DeckRepository> init() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [IsarDeckModelSchema],
      directory: dir.path,
    );
    return DeckRepository._create(isar);
  }

  Future<List<String>> getDeckNames() async {
    final decks = await isar.isarDeckModels.where().findAll();
    return decks.map((deck) => deck.deckName).toList();
  }

  Future<void> createDeck(String deckName) async {
    IsarDeckModel deckModel = IsarDeckModel(deckName: deckName, flashCards: []);
    await isar.writeTxn(() async {
      await isar.isarDeckModels.put(deckModel);
    });
    _decks.add(deckModel);
  }

  Future<bool> isDeckNameUsed(String deckName) async {
    IsarDeckModel? deckModel = await isar.isarDeckModels.filter().deckNameEqualTo(deckName).findFirst();
    if (deckModel == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> setCurrentDeck(String deckName) async {
    IsarDeckModel? isarDeck = await isar.isarDeckModels.filter().deckNameEqualTo(deckName).findFirst();
    if (isarDeck != null) {
      _currentDeck = isarDeck.toDomain();
    } else {
      throw Exception('Deck $deckName is unknown.');
    }
  }

  String getCurrentDeck() {
    if (_currentDeck != null) {
      return _currentDeck!.deckName;
    } else {
      throw Exception('No deck selected.');
    }
  }

  void setCurrentFlashCard({int? cardId}) {
    if (cardId == null) {
      _currentFlashCard = null;
    } else {
      if (_currentDeck == null) {
        throw Exception('CurrentDeck was null.');
      } else {
        for (FlashCardModel flashCard in _currentDeck!.flashCards) {
          if (flashCard.id == cardId) {
            _currentFlashCard = flashCard;
          }
        }
      }
    }
  }

  FlashCardModel? getCurrentFlashCard() {
    // ignore: unnecessary_null_comparison
    if (_currentFlashCard == null || _currentFlashCard!.question == null || _currentFlashCard!.answer == null) {
      return null;
    }
    return _currentFlashCard!;
  }

  Future<void> addFlashCard({required String question, required String answer}) async {
    if (_currentDeck != null) {
      final flashCard = FlashCardModel(id: _getIdForNewFlashCard(), question: question, answer: answer);
      _currentDeck!.flashCards = List<FlashCardModel>.from(_currentDeck!.flashCards);
      _currentDeck!.flashCards.add(flashCard);

      IsarDeckModel isarDeckModel = _currentDeck!.toIsar();
      await isar.writeTxn(() async {
        await isar.isarDeckModels.put(isarDeckModel);
      });

      final updatedDeck = await isar.isarDeckModels.filter().deckNameEqualTo(_currentDeck!.deckName).findFirst();
      if (updatedDeck != null) {
        _currentDeck = updatedDeck.toDomain();
      }
    } else {
      throw Exception('No deck selected');
    }
  }

  int _getIdForNewFlashCard() {
    if (_currentDeck == null || _currentDeck!.flashCards.isEmpty) {
      return 1;
    }
    final maxId =
        _currentDeck!.flashCards.map((fc) => fc.id).reduce((value, element) => value > element ? value : element);
    return maxId + 1;
  }

  List<FlashCardModel> getFlashCardsFromSelectedDeck() {
    if (_currentDeck != null) {
      return _currentDeck!.flashCards;
    } else {
      throw Exception('No deck selected');
    }
  }

  FlashCardModel getFlashCardsFromSelectedDeckById(int cardId) {
    if (_currentDeck != null) {
      FlashCardModel? flashCard;
      for (FlashCardModel flashCardModel in _currentDeck!.flashCards) {
        if (flashCardModel.id == cardId) {
          flashCard = flashCardModel;
        }
      }
      if (flashCard == null) {
        throw Exception('Flashcard with $cardId not found. Sync missmatch!');
      } else {
        return flashCard;
      }
    } else {
      throw Exception('No deck selected');
    }
  }

  Future<void> removeFlashCardFromSelectedDeckById(int cardId) async {
    if (_currentDeck == null) {
      throw Exception('No deck selected');
    }

    final int index = _currentDeck!.flashCards.indexWhere((flashCard) => flashCard.id == cardId);
    if (index == -1) {
      throw Exception('Flashcard with id $cardId not found in current deck.');
    }

    _currentDeck!.flashCards = List<FlashCardModel>.from(_currentDeck!.flashCards)..removeAt(index);

    final IsarDeckModel isarDeckModel = _currentDeck!.toIsar();
    await isar.writeTxn(() async {
      await isar.isarDeckModels.put(isarDeckModel);
    });

    final updatedDeck = await isar.isarDeckModels.filter().deckNameEqualTo(_currentDeck!.deckName).findFirst();
    if (updatedDeck != null) {
      _currentDeck = updatedDeck.toDomain();
    }
  }
}
