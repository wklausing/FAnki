part of 'deck_bloc.dart';

final class DeckState {
  final bool isLoading;
  final List<FlashCardModel> flashCards;

  const DeckState({
    this.isLoading = false,
    this.flashCards = const [],
  });

  DeckState copyWith({
    bool? isLoading,
    List<FlashCardModel>? flashCards,
  }) {
    return DeckState(
      isLoading: isLoading ?? this.isLoading,
      flashCards: flashCards ?? this.flashCards,
    );
  }
}
