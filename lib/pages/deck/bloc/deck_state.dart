part of 'deck_bloc.dart';

final class DeckState {
  final bool isLoading;
  final String? deckName;
  final List<FlashCard> flashCards;

  const DeckState({
    this.isLoading = false,
    this.deckName,
    this.flashCards = const [],
  });

  DeckState copyWith({
    bool? isLoading,
    String? deckName,
    List<FlashCard>? flashCards,
  }) {
    return DeckState(
      isLoading: isLoading ?? this.isLoading,
      deckName: deckName ?? this.deckName,
      flashCards: flashCards ?? this.flashCards,
    );
  }
}
