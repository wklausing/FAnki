part of 'deck_selection_bloc.dart';

sealed class DeckSelectionEvent {
  const DeckSelectionEvent();
}

final class FetchDecks extends DeckSelectionEvent {}
