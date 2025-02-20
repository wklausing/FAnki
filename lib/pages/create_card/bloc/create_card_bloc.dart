import 'package:bloc/bloc.dart';
import 'package:deck_repository/deck_repository.dart';

part 'create_card_event.dart';
part 'create_card_state.dart';

class CreateCardBloc extends Bloc<CreateCard, CreateCardState> {
  final DeckRepository _deckRepository;

  CreateCardBloc({required DeckRepository deckRepository})
      : _deckRepository = deckRepository,
        super(const CreateCardState()) {
    on<CreateCard>(_createCard);
  }

  void _createCard(CreateCard event, Emitter<CreateCardState> emit) {
    emit(state.copyWith(isLoading: true));

    emit(state.copyWith(isLoading: false));
  }
}
