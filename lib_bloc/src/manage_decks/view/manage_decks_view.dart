import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/manage_decks_cubit.dart';

class ManageDecksView extends StatelessWidget {
  const ManageDecksView({super.key});

  @override
  Widget build(BuildContext context) {
    var decknameInputController;

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
                controller: decknameInputController,
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(),
                  hintText: 'New deckname',
                ),
              ),
            ),
            Spacer(flex: 10),
            ElevatedButton(
              onPressed: () {
                print('Manage Decks view');
              },
              child: Text('Create new deck'),
            ),
            Spacer(flex: 10),
          ],
        ),
      ),
    ]);
  }

  Widget _listOfDecks(BuildContext appState) {
    List<String> deckNames = appState.read<ManageDecksCubit>().getDeckNames();
    return BlocBuilder<ManageDecksCubit, DecksState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: deckNames.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 4.0),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: ListTile(
                title: Text(deckNames[index]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    appState.read<ManageDecksCubit>().state.selectedDeck ==
                            index
                        ? Icon(Icons.check_circle, color: Colors.green)
                        : Icon(Icons.check_circle, color: Colors.grey),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.grey),
                      onPressed: () {
                        // _showMyDialog(appState, deckNames[index]);
                      },
                    ),
                  ],
                ),
                selected:
                    appState.read<ManageDecksCubit>().state.selectedDeck ==
                        index,
                onTap: () {
                  appState
                      .read<ManageDecksCubit>()
                      .selectDeck(deckNames[index]);
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showMyDialog(ManageDecksCubit appState, String deckName) async {
    // BuildContext context = null;
    // return showDialog<void>(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: const Text('Deck löschen'),
    //       content: SingleChildScrollView(
    //         child: ListBody(
    //           children: <Widget>[
    //             Text('Du willst das Deck \'$deckName\' wirklich löschen.'),
    //           ],
    //         ),
    //       ),
    //       actions: [
    //         TextButton(
    //           child: const Text('Bestätigen'),
    //           onPressed: () {
    //             appState.removeDeck(deckName);
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //         TextButton(
    //           child: const Text('Abbrechen'),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}
