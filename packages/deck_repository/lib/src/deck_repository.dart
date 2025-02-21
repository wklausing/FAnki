import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'models/deck_model.dart';
import 'models/flash_card_model.dart';

class DeckRepository {
  late final Isar isar;

  final List<DeckModel> _decks = [];
  DeckModel? _currentDeck;

  DeckRepository._create(this.isar);

  static Future<DeckRepository> init() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [DeckModelSchema],
      directory: dir.path,
    );
    return DeckRepository._create(isar);
  }

  Future<List<String>> getDecks() async {
    final decks = await isar.deckModels.where().findAll();
    return decks.map((deck) => deck.deckName).toList();
  }

  Future<void> createDeck(String deckName) async {
    DeckModel deckModel = DeckModel(deckName: deckName, flashCards: []);
    await isar.writeTxn(() async {
      await isar.deckModels.put(deckModel);
    });
    _decks.add(deckModel);
  }

  Future<bool> isDeckNameUsed(String deckName) async {
    DeckModel? deckModel = await isar.deckModels.filter().deckNameEqualTo(deckName).findFirst();
    if (deckModel == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> setCurrentDeck(String deckName) async {
    _currentDeck = await isar.deckModels.filter().deckNameEqualTo(deckName).findFirst();
    if (_currentDeck == null) {
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

  Future<void> addFlashCard({required String question, required String answer}) async {
    if (_currentDeck != null) {
      final flashCard = FlashCardModel(question: question, answer: answer);
      _currentDeck!.flashCards = List<FlashCardModel>.from(_currentDeck!.flashCards);
      _currentDeck!.flashCards.add(flashCard);

      await isar.writeTxn(() async {
        await isar.deckModels.put(_currentDeck!);
      });

      final updatedDeck = await isar.deckModels.filter().deckNameEqualTo(_currentDeck!.deckName).findFirst();

      if (updatedDeck != null) {
        _currentDeck = updatedDeck;
      }
    } else {
      throw Exception('No deck selected');
    }
  }

  List<FlashCardModel> getFlashCardsFromSelectedDeck() {
    if (_currentDeck != null) {
      return _currentDeck!.flashCards;
    } else {
      throw Exception('No deck selected');
    }
  }

  Future<void> removeFlashCardFromSelectedDeck() async {
    if (_currentDeck != null) {
      // return _currentDeck!.flashCards;
    } else {
      throw Exception('No deck selected');
    }
  }
}
