import 'package:equatable/equatable.dart';

class Flashcard extends Equatable {
  final String question;
  final String answer;

  const Flashcard({
    required this.question,
    required this.answer,
  });

  @override
  List<Object?> get props => [question, answer];
}
