part of 'deck_bloc.dart';

sealed class DeckEvent {}

final class GetCurrentDeckFromRepository extends DeckEvent {
  final String? deckName;

  GetCurrentDeckFromRepository({this.deckName});
}

final class RemoveCardFromDeckById extends DeckEvent {
  final int id;

  RemoveCardFromDeckById({required this.id});
}

final class CreateNewCard extends DeckEvent {}

final class SetCurrentFlashCardForEditing extends DeckEvent {
  final int cardId;

  SetCurrentFlashCardForEditing({required this.cardId});
}
