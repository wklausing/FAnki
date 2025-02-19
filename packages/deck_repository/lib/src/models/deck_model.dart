class DeckModel {
  String? deckCreator;
  String deckName;
  int cardCount = 0;

  DeckModel(
      {required this.deckCreator, required this.deckName, this.cardCount = 0});
}
