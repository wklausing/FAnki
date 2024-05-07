import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'single_card.dart';

enum Difficulty { repeat, hard, good, easy }

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

  void fetchNextCard(AppState context, Difficulty diff) {
    setState(() {
      if (!answerIsVisible) {
        answerIsVisible = true;
      } else {
        answerIsVisible = false;
        setDifficultyAttributeOfCard(context.card, diff);
        context.nextRandomCard();
      }
    });
  }

  void setDifficultyAttributeOfCard(SingleCard card, Difficulty diff) {
    switch (diff) {
      case Difficulty.repeat:
        card.difficulty = card.difficulty * 1.5;
        break;
      case Difficulty.hard:
        card.difficulty = card.difficulty * 1.25;
      case Difficulty.good:
        card.difficulty = card.difficulty * .50;
        break;
      case Difficulty.easy:
        card.difficulty = card.difficulty * .25;
        break;
    }
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
                onPressed: () => {fetchNextCard(appState, Difficulty.repeat)},
                child: const Text('Nochmal')),
            SizedBox(width: 8),
            ElevatedButton(
                onPressed: () => {fetchNextCard(appState, Difficulty.hard)},
                child: const Text('Schwer')),
            SizedBox(width: 8),
            ElevatedButton(
                onPressed: () => {fetchNextCard(appState, Difficulty.good)},
                child: const Text('Gut')),
            SizedBox(width: 8),
            ElevatedButton(
                onPressed: () => {fetchNextCard(appState, Difficulty.easy)},
                child: const Text('Einfach')),
          ],
        ),
      ],
    );
  }
}
