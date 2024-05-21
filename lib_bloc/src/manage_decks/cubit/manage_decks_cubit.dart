import 'package:bloc/bloc.dart';
import 'package:fetch_cards/fetch_cards.dart';

class ManageDecksCubit extends Cubit<DeckState> {
  final CardDeckManager cdm;

  ManageDecksCubit({required CardDeckManager cardDeckManager})
      : cdm = cardDeckManager,
        super(DeckStateLoading()) {
    loadDeckNames();
  }

  void selectDeck(String deckName) {
    if (state is DeckStateFinished) {
      DeckStateFinished currentState = state as DeckStateFinished;
      final selectedDeck = currentState.deckNames.indexOf(deckName);
      emit(currentState.copyWith(selectedDeck: selectedDeck));
    } else {
      print('Error 73462432');
    }
  }

  void loadDeckNames() async {
    emit(DeckStateLoading());
    await cdm.getAllDecknamesFromFirestore();
    emit(DeckStateFinished(deckNames: cdm.deckNames, selectedDeck: -1));
  }

  void createDeck(String newDeckName) {}

  void removeDeck(String deckName) {}
}

abstract class DeckState {}

class DeckStateFinished extends DeckState {
  final List<String> deckNames;
  final int selectedDeck;

  DeckStateFinished({
    required this.deckNames,
    required this.selectedDeck,
  });

  DeckState copyWith({
    List<String>? deckNames,
    int? selectedDeck,
  }) {
    return DeckStateFinished(
      deckNames: deckNames ?? this.deckNames,
      selectedDeck: selectedDeck ?? this.selectedDeck,
    );
  }

  List<String> get getDeckNames => deckNames;
}

class DeckStateLoading extends DeckState {}

class DeckStateError extends DeckState {}
