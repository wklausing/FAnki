import 'package:anki_app/src/learning_page/model/flashcard.dart';
import 'package:flutter/material.dart';

class FlashcardWidget extends StatelessWidget {
  final Flashcard flashcard;
  final bool isAnswerShown;

  const FlashcardWidget({
    super.key,
    required this.flashcard,
    required this.isAnswerShown,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(24),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              flashcard.question,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            if (isAnswerShown) ...[
              const Divider(height: 32),
              Text(
                flashcard.answer,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
