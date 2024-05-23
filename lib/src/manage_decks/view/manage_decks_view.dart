import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/manage_decks_cubit.dart';

class ManageDecksView extends StatelessWidget {
  ManageDecksView({super.key});

  final _decknameInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: _listOfDecks(context),
      ),
      SizedBox(
        height: 210,
        child: Column(
          children: [
            Spacer(flex: 10),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: TextField(
                controller: _decknameInputController,
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(),
                  hintText: 'Neuer Stapel',
                ),
              ),
            ),
            Spacer(flex: 10),
            ElevatedButton(
              onPressed: () {
                String newDeckName = _decknameInputController.text;
                if (newDeckName != '') {
                  context.read<ManageDecksCubit>().createDeck(newDeckName);
                }
              },
              child: Text('Neuen Stapel erstellen'),
            ),
            Spacer(flex: 10),
          ],
        ),
      ),
    ]);
  }

  Widget _listOfDecks(BuildContext context) {
    return BlocBuilder<ManageDecksCubit, DeckState>(
      builder: (context, state) {
        if (state is DeckStateFinished) {
          List<String> deckNames = state.getDeckNames;
          return ListView.builder(
            itemCount: deckNames.length,
            padding: EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 4.0),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: ListTile(
                  title: Text(deckNames[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: state.selectedDeck == index
                            ? Colors.green
                            : Colors.grey,
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.grey),
                        onPressed: () {
                          _showDeckRemovalDialog(context, deckNames[index]);
                        },
                      ),
                    ],
                  ),
                  selected: state.selectedDeck == index,
                  onTap: () {
                    context
                        .read<ManageDecksCubit>()
                        .selectDeck(deckNames[index]);
                  },
                ),
              );
            },
          );
        } else if (state is DeckStateLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: Text('Error loading decks'),
          );
        }
      },
    );
  }

  Future<void> _showDeckRemovalDialog(
      BuildContext appState, String deckName) async {
    return showDialog<void>(
      context: appState,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deck löschen'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Du willst das Deck \'$deckName\' wirklich löschen. \nAlle inhaltenen Karten werden ebenfalls gelöscht.'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Bestätigen'),
              onPressed: () {
                appState.read<ManageDecksCubit>().removeDeck(deckName);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Abbrechen'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
