part of 'create_card_bloc.dart';

final class CreateCardState {
  final bool isLoading;
  final bool cardIsValid;
  final String question;
  final String answer;

  const CreateCardState({
    this.isLoading = false,
    this.cardIsValid = false,
    this.question = '',
    this.answer = '',
  });

  CreateCardState copyWith({
    bool? isLoading,
    bool? cardIsValid,
    String? question,
    String? answer,
  }) {
    return CreateCardState(
      isLoading: isLoading ?? this.isLoading,
      cardIsValid: cardIsValid ?? this.cardIsValid,
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }
}
