import 'models/deck_model.dart';

class DeckRepository {
  final bool _foo;
  final List<DeckModel> _decks = [];

  DeckRepository({required foo}) : _foo = foo;

  List<DeckModel> getDecks() {
    DeckModel deckModel = DeckModel(title: "Zebras");
    _decks.add(deckModel);
    return _decks;
  }

  void addDeck(DeckModel deck) {
    _decks.add(deck);
  }
}
