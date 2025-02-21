import 'package:isar/isar.dart';

part 'flash_card_model.g.dart';

@embedded
class FlashCardModel {
  String? question;

  String? answer;

  FlashCardModel({this.question, this.answer});
}
