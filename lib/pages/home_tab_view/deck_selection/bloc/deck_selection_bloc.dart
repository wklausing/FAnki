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
    on<CreateNewDeck>(_createNewDeck);
  }

  void _onFetchDecks(
    FetchDecks event,
    Emitter<DeckSelectionState> emit,
  ) {
    emit(state.copyWith(isLoading: true));

    List<DeckModel> decks = _deckRepository.getDecks();

    emit(state.copyWith(isLoading: false, decks: decks));
  }

  void _onDeckNameInputChanged(
    DeckNameInputChange event,
    Emitter<DeckSelectionState> emit,
  ) {
    final deckName = DeckName.dirty(event.deckName);
    final deckNameIsValid = deckName.isValid;
    emit(state.copyWith(deckName: deckName, deckNameIsValid: deckNameIsValid));
  }

  void _createNewDeck(
    CreateNewDeck event,
    Emitter<DeckSelectionState> emit,
  ) {
    String deckName = event.deckName;
    DeckModel newDeck = DeckModel(deckCreator: 'foo', deckName: deckName, cardCount: 0);
    _deckRepository.addDeck(newDeck);
    emit(state.copyWith(deckName: DeckName.pure(), deckNameIsValid: false));
  }
}
