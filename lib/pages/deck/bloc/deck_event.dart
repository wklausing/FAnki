part of 'deck_bloc.dart';

sealed class DeckEvent {}

final class GetCurrentDeckFromRepository extends DeckEvent {
  final String? deckName;

  GetCurrentDeckFromRepository({this.deckName});
}

final class RemoveCardFromDeck extends DeckEvent {
  // FlashCard
}
