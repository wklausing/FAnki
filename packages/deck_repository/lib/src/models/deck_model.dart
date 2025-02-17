class DeckModel {
  String? deckCreator;
  String title;
  int cardCount = 0;

  DeckModel(
      {required this.deckCreator, required this.title, this.cardCount = 0});
}
