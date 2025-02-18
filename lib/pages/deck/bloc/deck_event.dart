part of 'deck_bloc.dart';

sealed class DeckEvent {}

final class FetchFlashCardsForDeckEvent extends DeckEvent {
  final String deckName;

  FetchFlashCardsForDeckEvent({required this.deckName});
}
