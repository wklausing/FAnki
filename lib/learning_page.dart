import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card_deck_manager.dart';
import 'app_state.dart';
import 'single_card.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({
    super.key,
  });

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  bool cardsNotLoaded = false;
  bool answerIsVisible = false;
  SingleCard? sCard;

  void selectNextCard() {
    CardDeckManager cardDeckManager = context.read<AppState>().cardDeckManager;
    sCard = cardDeckManager.nextCard();
  }

  void fetchNextCard(AppState context) {
    setState(() {
      if (!answerIsVisible) {
        answerIsVisible = true;
      } else {
        answerIsVisible = false;
        context.nextCard();
      }
    });
  }

  void toggleAnswerVisibility() {
    setState(() {
      answerIsVisible = !answerIsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    final theme = Theme.of(context);
    final questionStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
      fontSize: 24,
      shadows: [
        Shadow(
          blurRadius: 2.0,
          color: Colors.black.withOpacity(0.3),
          offset: Offset(1.0, 1.0),
        ),
      ],
    );
    final answerStyle = theme.textTheme.labelSmall!.copyWith(
      color: theme.colorScheme.onSecondary,
      fontSize: 20,
    );

    //if (cardsNotLoaded) appState.loadCardsFromDeck();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Center(
          child: InkWell(
            onTap: toggleAnswerVisibility,
            child: Container(
              width: 500,
              height: 300,
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    appState.card.questionText,
                    textAlign: TextAlign.center,
                    style: questionStyle,
                  ),
                  SizedBox(height: 20),
                  Divider(color: Colors.transparent),
                  Expanded(
                    child: AnimatedOpacity(
                      opacity: answerIsVisible ? 1 : 0.0,
                      duration: Duration(milliseconds: 0),
                      child: Text(
                        appState.card.answerText,
                        textAlign: TextAlign.center,
                        style: answerStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => {fetchNextCard(appState)},
                child: const Text('Nochmal')),
            SizedBox(width: 8),
            ElevatedButton(
                onPressed: () => {fetchNextCard(appState)},
                child: const Text('Schwer')),
            SizedBox(width: 8),
            ElevatedButton(
                onPressed: () => {fetchNextCard(appState)},
                child: const Text('Gut')),
            SizedBox(width: 8),
            ElevatedButton(
                onPressed: () => {fetchNextCard(appState)},
                child: const Text('Einfach')),
          ],
        ),
      ],
    );
  }
}
