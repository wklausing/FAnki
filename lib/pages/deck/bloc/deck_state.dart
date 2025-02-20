part of 'deck_bloc.dart';

final class DeckState {
  final bool isLoading;
  final DeckModel? deck;

  const DeckState({
    this.isLoading = false,
    this.deck,
  });

  DeckState copyWith({
    bool? isLoading,
    DeckModel? deck,
  }) {
    return DeckState(
      isLoading: isLoading ?? this.isLoading,
      deck: deck ?? this.deck,
    );
  }
}
