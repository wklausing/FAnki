part of 'deck_selection_bloc.dart';

final class DeckSelectionState {
  const DeckSelectionState({
    this.isLoading = true,
    this.decks = const [],
  });

  final bool isLoading;
  final List<DeckModel> decks;

  DeckSelectionState copyWith({
    bool? isLoading,
    List<DeckModel>? decks,
  }) {
    return DeckSelectionState(
      isLoading: isLoading ?? this.isLoading,
      decks: decks ?? this.decks,
    );
  }
}
