import 'package:bloc/bloc.dart';
import 'package:deck_repository/deck_repository.dart';

part 'deck_selection_event.dart';
part 'deck_selection_state.dart';

class DeckSelectionBloc extends Bloc<DeckSelectionEvent, DeckSelectionState> {
  final DeckRepository _deckRepository;

  DeckSelectionBloc({required DeckRepository deckRepository})
      : _deckRepository = deckRepository,
        super(const DeckSelectionState()) {
    on<FetchDecks>(_onFetchDecks);
  }

  Future<void> _onFetchDecks(
    FetchDecks event,
    Emitter<DeckSelectionState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // await Future.delayed(Duration(seconds: 2));
    List<DeckModel> decks = _deckRepository.getDecks();

    emit(state.copyWith(isLoading: false, decks: decks));
  }
}
