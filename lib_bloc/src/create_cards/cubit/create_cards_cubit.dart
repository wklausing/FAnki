import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:fetch_cards/fetch_cards.dart';

class CreateCardsCubit extends Cubit<CreateCardsState> {
  // ignore: unused_field
  final AuthenticationRepository _repo;
  final CardDeckManager cdm;
  String deckName = '';
  List<SingleCard> cards = [];

  CreateCardsCubit(
      {required AuthenticationRepository repo,
      required CardDeckManager cardDeckManager})
      : _repo = repo,
        cdm = cardDeckManager,
        super(CreateCardLoadingState()) {
    deckName = cdm.currentDeckName;
    loadCardsOfDeck();
  }

  void addCard(String question, String answer) {
    cdm.addCardWithQA(question, answer);
    cards = cdm.getCurrentDeck();
    emit(CreateCardViewingState(deckName: deckName, cards: cards));
  }

  void removeCard(String cardID) {
    cdm.removeCardByID(cardID);
    cards = cdm.getCurrentDeck();
    if (cards.isEmpty) {
      emit(CreateCardEmptyState());
    } else {
      emit(CreateCardViewingState(deckName: deckName, cards: cards));
    }
  }

  void loadCardsOfDeck() async {
    emit(CreateCardLoadingState());
    cards = cdm.getCurrentDeck();
    if (cards.isEmpty) {
      emit(CreateCardEmptyState());
    } else {
      deckName = cdm.currentDeckName;
      emit(CreateCardViewingState(deckName: deckName, cards: cards));
    }
  }

  void checkAndReloadDeck() {
    if (deckName != cdm.currentDeckName) {
      deckName = cdm.currentDeckName;
      loadCardsOfDeck();
    }
  }
}

abstract class CreateCardsState {}

class CreateCardLoadingState extends CreateCardsState {}

class CreateCardViewingState extends CreateCardsState {
  final String _deckName;
  final List<SingleCard> _cards;

  String get deckName => _deckName;
  List<SingleCard> get cards => _cards;

  CreateCardViewingState(
      {required String deckName, required List<SingleCard> cards})
      : _deckName = deckName,
        _cards = cards;
}

class CreateCardEmptyState extends CreateCardsState {}
