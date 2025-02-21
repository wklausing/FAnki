import 'package:fanki/pages/deck/bloc/deck_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'widgets/flashcard.dart';

class DeckPage extends StatefulWidget {
  const DeckPage({super.key});

  @override
  State<DeckPage> createState() => _DeckPageState();
}

class _DeckPageState extends State<DeckPage> {
  @override
  void didUpdateWidget(covariant DeckPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    context.read<DeckBloc>().add(GetCurrentDeckFromRepository());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cards'),
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
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  state.deckName ?? 'No Name Error',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: state.isLoading || state.deckName == null
                      ? const Center(child: CircularProgressIndicator())
                      : state.flashCards.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('There are no cards for this deck yet.'),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: state.flashCards.length,
                              itemBuilder: (context, index) {
                                return FlashCard(
                                  index: index,
                                  question: state.flashCards[index].question,
                                  answer: state.flashCards[index].answer,
                                );
                              },
                            ),
                ),
                const SizedBox(height: 16.0),
                _addNewCardButton(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _addNewCardButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.go('/HomeTabView/DeckPage/CreateCardPage'),
      child: const Text('Add new card'),
    );
  }
}
