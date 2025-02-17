import 'package:bloc/bloc.dart';
import 'package:deck_repository/deck_repository.dart';

part 'deck_selection_event.dart';
part 'deck_selection_state.dart';

class DeckSelectionBloc extends Bloc<DeckSelectionEvent, DeckSelectionState> {
  DeckRepository _deckRepository;

  DeckSelectionBloc({required DeckRepository deckRepository})
      : _deckRepository = deckRepository,
        super(const DeckSelectionState()) {
    on<FetchDecks>(_onFetchDeck);
  }

  void _onFetchDeck(
    FetchDecks event,
    Emitter<DeckSelectionState> emit,
  ) {
    emit(state.copyWith(isLoading: true));

    Future.delayed(Duration(seconds: 2));
    List<DeckModel> decks = _deckRepository.getDecks();

    emit(state.copyWith(isLoading: false, decks: decks));
  }
}
