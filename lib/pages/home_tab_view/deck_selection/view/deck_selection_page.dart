import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fanki/pages/home_tab_view/deck_selection/deck_selection.dart';
import 'package:go_router/go_router.dart';

class DeckSelectionPage extends StatelessWidget {
  const DeckSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeckSelectionBloc, DeckSelectionState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: state.decks.length,
                    itemBuilder: (context, index) => Card(
                      child: ListTile(
                        title: Text(state.decks[index].deckName),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                context.push('/HomeTabView/DeckPage', extra: 'mockDeck');
                              },
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _createDeckDialog(context);
                  },
                  child: const Text('Create new deck'),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  void _createDeckDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<DeckSelectionBloc>(context),
          child: BlocBuilder<DeckSelectionBloc, DeckSelectionState>(
            builder: (context, state) {
              return FractionallySizedBox(
                heightFactor: 0.8,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        Text(
                          'Create New Deck',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          onChanged: (deckName) {
                            context.read<DeckSelectionBloc>().add(DeckNameInputChange(deckName: deckName));
                          },
                          decoration: const InputDecoration(
                            labelText: 'Deck Title',
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: state.deckNameIsValid
                                  ? () {
                                      context
                                          .read<DeckSelectionBloc>()
                                          .add(CreateNewDeck(deckName: state.deckName.value));
                                      Navigator.of(context).pop();
                                    }
                                  : null,
                              child: const Text('Create Deck'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                context.read<DeckSelectionBloc>().add(DeckNameInputChange(deckName: ''));
                                Navigator.of(context).pop();
                              },
                              child: const Text('Abort'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
