part of 'deck_selection_bloc.dart';

sealed class DeckSelectionEvent {
  const DeckSelectionEvent();
}

final class FetchDecks extends DeckSelectionEvent {}

final class DeckNameInputChange extends DeckSelectionEvent {
  final String deckName;

  const DeckNameInputChange({required this.deckName});
}

final class CreateNewDeck extends DeckSelectionEvent {
  final String deckName;

  const CreateNewDeck({required this.deckName});
}
