import 'package:deck_repository/deck_repository.dart';

class DeckModel {
  String? deckCreator;
  String deckName;
  List<FlashCardModel> flashCards = [];

  DeckModel({required this.deckCreator, required this.deckName, required this.flashCards});
}
