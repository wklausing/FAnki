import 'models/deck_model.dart';

class DeckRepository {
  final bool _foo;
  final List<DeckModel> _decks = [];

  DeckRepository({required foo}) : _foo = foo;

  List<DeckModel> getDecks() {
    DeckModel deckModel = DeckModel(deckCreator: "Name", title: "Zebras");
    _decks.add(deckModel);
    DeckModel deckModel2 = DeckModel(deckCreator: "Name", title: "Zebras2");
    _decks.add(deckModel2);
    return _decks;
  }

  void addDeck(DeckModel deck) {
    _decks.add(deck);
  }
}
