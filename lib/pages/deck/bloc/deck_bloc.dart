import 'package:bloc/bloc.dart';
import 'package:deck_repository/deck_repository.dart';
import 'package:fanki/pages/deck/view/widgets/flashcard.dart';

part 'deck_event.dart';
part 'deck_state.dart';

class DeckBloc extends Bloc<DeckEvent, DeckState> {
  final DeckRepository _deckRepository;

  DeckBloc({required DeckRepository deckRepository})
      : _deckRepository = deckRepository,
        super(const DeckState()) {
    on<GetCurrentDeckFromRepository>(_getCurrentDeckFromRepository);
    on<RemoveCardFromDeck>(_removeCard);
  }

  Future<void> _getCurrentDeckFromRepository(GetCurrentDeckFromRepository event, Emitter<DeckState> emit) async {
    emit(state.copyWith(isLoading: true));
    if (event.deckName != null) {
      await _deckRepository.setCurrentDeck(event.deckName!);
    }

    final flashCardModels = _deckRepository.getFlashCardsFromSelectedDeck();
    final flashCards = flashCardModels
        .map((model) => FlashCard(index: 0, question: model.question ?? '', answer: model.answer ?? ''))
        .toList();

    emit(state.copyWith(isLoading: false, deckName: event.deckName, flashCards: flashCards));
  }

  Future<void> _removeCard(RemoveCardFromDeck event, Emitter<DeckState> emit) async {
    await _deckRepository.removeFlashCardFromSelectedDeck();
  }
}
