import 'package:bloc/bloc.dart';
import 'package:deck_repository/deck_repository.dart';

part 'deck_event.dart';
part 'deck_state.dart';

class DeckBloc extends Bloc<DeckEvent, DeckState> {
  final DeckRepository _deckRepository;

  DeckBloc({required DeckRepository deckRepository})
      : _deckRepository = deckRepository,
        super(const DeckState()) {
    on<GetCurrentDeckFromRepository>(_getCurrentDeckFromRepository);
    on<RemoveCardFromDeckById>(_removeCard);
    on<CreateNewCard>(_createNewCard);
    on<SetCurrentFlashCardForEditing>(_setCurrentFlashCard);
  }

  Future<void> _getCurrentDeckFromRepository(GetCurrentDeckFromRepository event, Emitter<DeckState> emit) async {
    emit(state.copyWith(isLoading: true));
    if (event.deckName != null) {
      await _deckRepository.setCurrentDeck(event.deckName!);
    }

    final flashCardModels = _deckRepository.getFlashCardsFromSelectedDeck();

    emit(state.copyWith(isLoading: false, deckName: event.deckName, flashCards: flashCardModels));
  }

  Future<void> _removeCard(RemoveCardFromDeckById event, Emitter<DeckState> emit) async {
    await _deckRepository.removeFlashCardFromSelectedDeckById(event.id);
  }

  void _createNewCard(CreateNewCard event, Emitter<DeckState> emit) {
    _deckRepository.setCurrentFlashCard();
  }

  Future<void> _setCurrentFlashCard(SetCurrentFlashCardForEditing event, Emitter<DeckState> emit) async {
    _deckRepository.setCurrentFlashCard(cardId: event.cardId);
  }
}
