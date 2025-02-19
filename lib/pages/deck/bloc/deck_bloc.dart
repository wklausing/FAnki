import 'package:bloc/bloc.dart';
import 'package:deck_repository/deck_repository.dart';

part 'deck_event.dart';
part 'deck_state.dart';

class DeckBloc extends Bloc<DeckEvent, DeckState> {
  final DeckRepository deckRepository;

  DeckBloc({required this.deckRepository}) : super(const DeckState()) {
    on<FetchFlashCardsForDeckEvent>(_fetchCards);
  }

  Future<void> _fetchCards(
      FetchFlashCardsForDeckEvent event, Emitter<DeckState> emit) async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(Duration(seconds: 1));
    List<FlashCardModel> flashCards = deckRepository.getRandomMockFlashCards();

    emit(state.copyWith(isLoading: false, flashCards: flashCards));
  }
}
