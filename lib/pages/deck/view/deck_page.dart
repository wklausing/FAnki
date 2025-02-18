import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/flashcard.dart';

class DeckPage extends StatelessWidget {
  const DeckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Deck Modifying Page'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Deck Name',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Flexible(
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) => FlashCard(
                            index: index,
                            question: 'What is the capital of France?',
                            answer: 'Paris',
                          )),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: null,
                  child: const Text('Add new card'),
                ),
              ],
            ),
          ),
        ));
  }
}
