part of 'deck_selection_bloc.dart';

final class DeckSelectionState {
  final bool isLoading;
  final List<DeckModel> decks;
  final DeckName deckName;
  final bool deckNameIsValid;

  const DeckSelectionState({
    this.isLoading = true,
    this.decks = const [],
    this.deckName = const DeckName.pure(),
    this.deckNameIsValid = false,
  });

  DeckSelectionState copyWith({
    bool? isLoading,
    List<DeckModel>? decks,
    DeckName? deckName,
    bool? deckNameIsValid,
  }) {
    return DeckSelectionState(
      isLoading: isLoading ?? this.isLoading,
      decks: decks ?? this.decks,
      deckName: deckName ?? this.deckName,
      deckNameIsValid: deckNameIsValid ?? this.deckNameIsValid,
    );
  }
}
