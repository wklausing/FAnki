import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:fetch_cards/fetch_cards.dart';

class CreateCardsCubit extends Cubit<CreateCardsState> {
  // ignore: unused_field
  final AuthenticationRepository _repo;
  final CardDeckManager cdm;
  List<SingleCard> cards = [];

  CreateCardsCubit(
      {required AuthenticationRepository repo,
      required CardDeckManager cardDeckManager})
      : _repo = repo,
        cdm = cardDeckManager,
        super(CreateCardLoadingState()) {
    loadCardsOfDeck();
  }

  void addCard(String question, String answer) {
    cdm.addCardWithQA(question, answer);
    cards = cdm.getCurrentDeck();
    emit(CreateCardViewingState(cards));
  }

  void removeCard(String cardID) {
    cdm.removeCardByID(cardID);
    cards = cdm.getCurrentDeck();
    emit(CreateCardViewingState(cards));
  }

  void loadCardsOfDeck() async {
    emit(CreateCardLoadingState());
    if (cards.isEmpty) {
      cards = cdm.getCurrentDeck();
      emit(CreateCardViewingState(cards));
    }
    emit(CreateCardViewingState(cards));
  }
}

abstract class CreateCardsState {}

class CreateCardLoadingState extends CreateCardsState {}

class CreateCardViewingState extends CreateCardsState {
  List<SingleCard> _cards = [];
  List<SingleCard> get cards => _cards;

  CreateCardViewingState(List<SingleCard> cards) {
    _cards = cards;
  }
}

class CreateCardEmptyState extends CreateCardsState {}
