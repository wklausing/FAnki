import 'package:fanki/pages/deck/bloc/deck_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      body: BlocBuilder<DeckBloc, DeckState>(
        builder: (context, state) {
          if (state.isLoading || state.deck == null) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.deck!.flashCards.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('There no cards for this deck yet.'),
                  SizedBox(height: 16.0),
                  _addNewCardButton(context),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.deck?.deckName ?? 'No Name Error',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Flexible(
                      child: ListView.builder(
                          itemCount: state.deck?.flashCards.length ?? 0,
                          itemBuilder: (context, index) {
                            return FlashCard(
                              index: index,
                              question: state.deck?.flashCards[index].question ?? 'Question Error',
                              answer: state.deck?.flashCards[index].answer ?? 'Answer Error',
                            );
                          }),
                    ),
                    const SizedBox(height: 16.0),
                    _addNewCardButton(context),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _addNewCardButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.push('/CreateCardPage'),
      child: const Text('Add new card'),
    );
  }
}
