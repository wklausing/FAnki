import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'app_state.dart';
import 'single_card.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class CreateCardsPage extends StatefulWidget {
  const CreateCardsPage({super.key});

  @override
  State<CreateCardsPage> createState() => _CreateCardsPageState();
}

class _CreateCardsPageState extends State<CreateCardsPage> {
  final frontController = TextEditingController();
  final backController = TextEditingController();
  final String front = 'front';
  final String back = 'back';

  @override
  void dispose() {
    frontController.dispose();
    backController.dispose();
    super.dispose();
  }

  void clearTextfields() {
    if (frontController.text != '' || backController.text != '') {
      frontController.clear();
      backController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();

    void saveCard() {
      if (frontController.text != '' || backController.text != '') {
        SingleCard newCard = SingleCard(
          deckName: state.cardDeckManager.currentDeckName,
          questionText: frontController.text,
          answerText: backController.text,
        );
        state.addCard(newCard);
      }
      clearTextfields();
    }

    List<Widget> listOfCards(List<SingleCard> listOfSubjects) {
      List<Widget> cardTilesList = [];
      List<SingleCard> cardList = listOfSubjects.toList();
      for (int i = 0; i < cardList.length; i++) {
        final card = cardList[i];
        cardTilesList.add(
          InkWell(
            onTap: () {
              frontController.text = card.questionText;
              backController.text = card.answerText;
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              ),
              child: ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        card.questionText,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          state.removeCard(card);
                          log.info('Card removed.');
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Card removed'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                subtitle: Text(
                  card.answerText,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                isThreeLine: true,
              ),
            ),
          ),
        );
      }
      return cardTilesList;
    }

    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
              future: state.cardDeckManager.loadDeck(),
              builder: (snap, context) {
                if (context.connectionState.name == 'done') {
                  return ListView(
                    reverse: true,
                    children: listOfCards(state.cardDeckManager.getDeck()!),
                  );
                } else {
                  return LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.black,
                    size: 100,
                  );
                }
              }),
        ),
        SizedBox(
          height: 210,
          child: Column(
            children: [
              Spacer(flex: 10),
              FractionallySizedBox(
                widthFactor: 0.9,
                child: TextField(
                  controller: frontController,
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Insert front site here.',
                  ),
                ),
              ),
              Spacer(flex: 10),
              FractionallySizedBox(
                widthFactor: 0.9,
                child: TextField(
                  controller: backController,
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Insert back site here.',
                  ),
                ),
              ),
              Spacer(flex: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      saveCard();
                    },
                    child: Text('Save'),
                  ),
                  const SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () {
                      clearTextfields();
                    },
                    child: Text('Clear'),
                  ),
                ],
              ),
              Spacer(flex: 100),
            ],
          ),
        ),
      ],
    );
  }
}
