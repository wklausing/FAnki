import 'package:bloc/bloc.dart';
import 'single_card.dart';

class CreateCardsCubit extends Cubit<CreateCardsState> {
  CreateCardsCubit(super.initialState);
}

class CreateCardsState {
  SingleCard card = SingleCard(
      deckName: 'deckName',
      questionText: 'questionText',
      answerText: 'answerText');
  List<SingleCard> deck = [];

  CreateCardsState() {
    deck.add(card);
  }
}
