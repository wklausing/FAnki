part of 'create_card_bloc.dart';

sealed class CreateCard {}

final class InitializeFlashCard extends CreateCard {
  final int? flashcardId;

  InitializeFlashCard({this.flashcardId});
}

final class QuestionChanged extends CreateCard {
  final String question;

  QuestionChanged({required this.question});
}

final class AnswerChanged extends CreateCard {
  final String answer;

  AnswerChanged({required this.answer});
}

final class CardIsValidCheck extends CreateCard {}

final class CreateNewCard extends CreateCard {}

final class RemoveCard extends CreateCard {
  final int cardId;

  RemoveCard({required this.cardId});
}
