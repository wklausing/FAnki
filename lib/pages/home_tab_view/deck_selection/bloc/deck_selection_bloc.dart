import 'package:bloc/bloc.dart';
import 'package:deck_repository/deck_repository.dart';

import '../models/models.dart';

part 'deck_selection_event.dart';
part 'deck_selection_state.dart';

class DeckSelectionBloc extends Bloc<DeckSelectionEvent, DeckSelectionState> {
  final DeckRepository _deckRepository;

  DeckSelectionBloc({required DeckRepository deckRepository})
      : _deckRepository = deckRepository,
        super(const DeckSelectionState()) {
    on<FetchDecks>(_onFetchDecks);
    on<DeckNameInputChange>(_onDeckNameInputChanged);
    on<CreateDeck>(_createDeck);
    on<SelectDeck>(_selectDeck);
  }

  Future<void> _onFetchDecks(FetchDecks event, Emitter<DeckSelectionState> emit) async {
    emit(state.copyWith(isLoading: true));

    List<String> deckNamesFromRepo = await _deckRepository.getDeckNames();
    List<DeckName> deckNames = [];
    for (String deckName in deckNamesFromRepo) {
      deckNames.add(DeckName.dirty(deckName));
    }

    emit(state.copyWith(isLoading: false, decks: deckNames));
  }

  Future<void> _onDeckNameInputChanged(DeckNameInputChange event, Emitter<DeckSelectionState> emit) async {
    final deckName = DeckName.dirty(event.deckName);
    final deckNameIsUsed = await _deckRepository.isDeckNameUsed(event.deckName);
    final deckNameIsValid = deckName.isValid && !deckNameIsUsed;
    emit(state.copyWith(deckName: deckName, deckNameIsValid: deckNameIsValid));
  }

  Future<void> _createDeck(CreateDeck event, Emitter<DeckSelectionState> emit) async {
    String deckName = event.deckName;
    await _deckRepository.createDeck(deckName);
    add(FetchDecks());
    emit(state.copyWith(deckName: DeckName.pure()));
  }

  Future<void> _selectDeck(SelectDeck event, Emitter<DeckSelectionState> emit) async {
    await _deckRepository.setCurrentDeck(event.deckName);
  }
}
