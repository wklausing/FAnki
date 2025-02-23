import 'package:deck_repository/deck_repository.dart';

class FlashCardModel {
  int id;

  String question;

  String answer;

  FlashCardModel({required this.id, required this.question, required this.answer});
}

extension FlashCardModelX on FlashCardModel {
  IsarFlashCardModel toIsar() {
    return IsarFlashCardModel(
      id: id,
      question: question,
      answer: answer,
    );
  }
}

extension IsarFlashCardModelX on IsarFlashCardModel {
  FlashCardModel toDomain() {
    // If question/answer can really be null in the DB,
    // then handle null-safety here (e.g., fallback to empty string).
    return FlashCardModel(
      question: question ?? '',
      answer: answer ?? '',
      id: id ?? -1,
    );
  }
}
