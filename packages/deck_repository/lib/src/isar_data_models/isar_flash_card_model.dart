import 'package:isar/isar.dart';

part 'isar_flash_card_model.g.dart';

@embedded
class IsarFlashCardModel {
  int? id;

  String? question;

  String? answer;

  IsarFlashCardModel({this.id, this.question, this.answer});
}
