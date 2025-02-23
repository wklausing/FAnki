part of 'create_card_bloc.dart';

final class CreateCardState {
  final bool isLoading;
  final bool isNewCard;
  final bool cardIsValid;
  final int cardId;
  final String question;
  final String answer;

  const CreateCardState({
    this.isLoading = false,
    this.isNewCard = true,
    this.cardIsValid = false,
    this.cardId = -1,
    this.question = '',
    this.answer = '',
  });

  CreateCardState copyWith({
    bool? isLoading,
    bool? isNewCard,
    bool? cardIsValid,
    int? cardId,
    String? question,
    String? answer,
  }) {
    return CreateCardState(
      isLoading: isLoading ?? this.isLoading,
      isNewCard: isNewCard ?? this.isNewCard,
      cardId: cardId ?? this.cardId,
      cardIsValid: cardIsValid ?? this.cardIsValid,
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }
}
