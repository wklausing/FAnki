part of 'create_card_bloc.dart';

sealed class CreateCard {}

final class QuestionChanged extends CreateCard {
  final String question;

  QuestionChanged({required this.question});
}

final class AnswerChanged extends CreateCard {
  final String answer;

  AnswerChanged({required this.answer});
}

final class CreateNewCard extends CreateCard {}
