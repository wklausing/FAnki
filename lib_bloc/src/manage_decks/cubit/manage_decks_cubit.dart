import 'package:bloc/bloc.dart';

class ManageDecksCubit extends Cubit<DecksState> {
  ManageDecksCubit({
    List<String>? initialDeckNames,
    int initialSelectedDeck = 0,
  }) : super(DecksState(
          deckNames: initialDeckNames ?? ['Deck1', 'Deck2'],
          selectedDeck: initialSelectedDeck,
        ));

  List<String> getDeckNames() {
    return state.deckNames;
  }

  void selectDeck(String deckName) {
    final selectedDeck = state.deckNames.indexOf(deckName);
    emit(state.copyWith(selectedDeck: selectedDeck));
  }

  void removeDeck(String deckName) {}

  void createDeck(String newDeckName) {}
}

class DecksState {
  final List<String> deckNames;
  final int selectedDeck;

  DecksState({
    required this.deckNames,
    required this.selectedDeck,
  });

  DecksState copyWith({
    List<String>? deckNames,
    int? selectedDeck,
  }) {
    return DecksState(
      deckNames: deckNames ?? this.deckNames,
      selectedDeck: selectedDeck ?? this.selectedDeck,
    );
  }
}
