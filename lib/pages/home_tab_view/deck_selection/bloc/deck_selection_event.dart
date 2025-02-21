part of 'deck_selection_bloc.dart';

sealed class DeckSelectionEvent {
  const DeckSelectionEvent();
}

final class FetchDecks extends DeckSelectionEvent {}

final class DeckNameInputChange extends DeckSelectionEvent {
  final String deckName;

  const DeckNameInputChange({required this.deckName});
}

final class CreateDeck extends DeckSelectionEvent {
  final String deckName;

  const CreateDeck({required this.deckName});
}

final class SelectDeck extends DeckSelectionEvent {
  final String deckName;

  const SelectDeck({required this.deckName});
}
