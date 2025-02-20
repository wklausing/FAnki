import 'package:bloc/bloc.dart';
import 'package:deck_repository/deck_repository.dart';

part 'deck_event.dart';
part 'deck_state.dart';

class DeckBloc extends Bloc<DeckEvent, DeckState> {
  final DeckRepository _deckRepository;

  DeckBloc({required DeckRepository deckRepository})
      : _deckRepository = deckRepository,
        super(const DeckState()) {
    on<GetSelectedDeckFromRepository>(_getSelectedDeckFromRepository);
  }

  void _getSelectedDeckFromRepository(GetSelectedDeckFromRepository event, Emitter<DeckState> emit) {
    emit(state.copyWith(isLoading: true));

    DeckModel deck = _deckRepository.getSelectedDeck();

    emit(state.copyWith(isLoading: false, deck: deck));
  }
}
