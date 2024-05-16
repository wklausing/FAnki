import 'package:bloc/bloc.dart';
import 'single_card.dart';

class CreateCardsCubit extends Cubit<CreateCardsState> {
  CreateCardsCubit(super.initialState);

  void removeCard(card) {}
}

class CreateCardsState {
  SingleCard card = SingleCard(
      deckName: 'deckName',
      questionText: 'questionText',
      answerText: 'answerText');
  List<SingleCard> deck = [];

  CreateCardsState() {
    deck.add(card);
    deck.add(card);
    deck.add(card);
    deck.add(card);
    deck.add(card);
  }

  get cards => null;

  bool get isLoading => true;
}
