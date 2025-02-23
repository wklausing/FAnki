import 'package:bloc/bloc.dart';
import 'package:deck_repository/deck_repository.dart';

part 'create_card_event.dart';
part 'create_card_state.dart';

class CreateCardBloc extends Bloc<CreateCard, CreateCardState> {
  final DeckRepository _deckRepository;

  CreateCardBloc({required DeckRepository deckRepository})
      : _deckRepository = deckRepository,
        super(const CreateCardState()) {
    on<InitializeFlashCard>(_initializeFlashcard);
    on<QuestionChanged>(_onQuestionChanged);
    on<AnswerChanged>(_onAnswerChanged);
    on<CreateNewCard>(_createCard);
    on<RemoveCard>(_removeCard);
  }

  void _initializeFlashcard(InitializeFlashCard event, Emitter<CreateCardState> emit) {
    final FlashCardModel? flashCard = _deckRepository.getCurrentFlashCard();
    if (flashCard != null) {
      bool cardIsValid = _cardIsValid(newQuestionInput: flashCard.question, newAnswerInput: flashCard.answer);
      emit(state.copyWith(
          isNewCard: false,
          cardId: flashCard.id,
          question: flashCard.question,
          answer: flashCard.answer,
          cardIsValid: cardIsValid));
    } else {
      emit(state.copyWith(isNewCard: true, question: '', answer: '', cardIsValid: false));
    }
  }

  void _onQuestionChanged(QuestionChanged event, Emitter<CreateCardState> emit) {
    emit(
      state.copyWith(cardIsValid: _cardIsValid(newQuestionInput: event.question), question: event.question),
    );
  }

  void _onAnswerChanged(AnswerChanged event, Emitter<CreateCardState> emit) {
    emit(
      state.copyWith(
        cardIsValid: _cardIsValid(newAnswerInput: event.answer),
        answer: event.answer,
      ),
    );
  }

  Future<void> _createCard(CreateNewCard event, Emitter<CreateCardState> emit) async {
    emit(state.copyWith(isLoading: true));
    await _deckRepository.addFlashCard(question: state.question, answer: state.answer);
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _removeCard(RemoveCard event, Emitter<CreateCardState> emit) async {
    emit(state.copyWith(isLoading: true));
    await _deckRepository.removeFlashCardFromSelectedDeckById(event.cardId);
    emit(state.copyWith(isLoading: false));
  }

  bool _cardIsValid({String? newQuestionInput, String? newAnswerInput}) {
    String question = newQuestionInput ?? state.question;
    String answer = newAnswerInput ?? state.answer;

    if (question.isNotEmpty && answer.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
