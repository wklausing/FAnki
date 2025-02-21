import 'package:deck_repository/deck_repository.dart';
import 'package:isar/isar.dart';

part 'deck_model.g.dart';

@collection
class DeckModel {
  Id id = Isar.autoIncrement;

  String? deckCreator;

  String deckName;

  List<FlashCardModel> flashCards;

  DeckModel({this.deckCreator, required this.deckName, required this.flashCards});
}
