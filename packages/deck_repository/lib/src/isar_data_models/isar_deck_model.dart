import 'package:deck_repository/deck_repository.dart';
import 'package:deck_repository/src/data_models/flash_card_model.dart';
import 'package:isar/isar.dart';

import '../data_models/deck_model.dart';

part 'isar_deck_model.g.dart';

@collection
class IsarDeckModel {
  Id id;

  String deckName;

  List<IsarFlashCardModel> flashCards;

  IsarDeckModel({this.id = Isar.autoIncrement, required this.deckName, required this.flashCards});
}

extension IsarDeckModelX on IsarDeckModel {
  DeckModel toDomain() {
    return DeckModel(
      id: id,
      deckName: deckName,
      flashCards: flashCards.map((isarFC) => isarFC.toDomain()).toList(),
    );
  }
}
