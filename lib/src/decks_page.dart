import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';

class DecksPage extends StatefulWidget {
  const DecksPage({super.key});

  @override
  State<DecksPage> createState() => _DecksPageState();
}

class _DecksPageState extends State<DecksPage> {
  final decknameInputController = TextEditingController();

  Future<void> _showMyDialog(AppState appState, String deckName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deck löschen'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Du willst das Deck \'$deckName\' wirklich löschen.'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Bestätigen'),
              onPressed: () {
                appState.cardDeckManager.removeDeckFromFirestore(deckName);
                appState.loadDecknames();
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

  Widget _listOfDecks(AppState appState) {
    List<String> deckNames = appState.deckNames.toList();
    if (deckNames.isNotEmpty) {
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
                    appState.selectedDeckIndex == index
                        ? Icon(Icons.check_circle, color: Colors.green)
                        : Icon(Icons.check_circle, color: Colors.grey),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        _showMyDialog(appState, deckNames[index]);
                      },
                      icon: Icon(Icons.delete, color: Colors.grey),
                    ),
                  ],
                ),
                selected: appState.selectedDeckIndex == index,
                onTap: () {
                  appState.changeDeck(deckNames[index]);
                },
              ),
            );
          });
    } else {
      return ListTile(title: Text('Loading'), tileColor: Colors.amber);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppState appState = context.watch<AppState>();

    return Column(children: [
      Expanded(
        child: _listOfDecks(appState),
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
                String newDeckName = decknameInputController.text;
                if (newDeckName != '') {
                  appState.createDeck(newDeckName);
                  appState.loadDecknames();
                  decknameInputController.clear();
                }
              },
              child: Text('Create new deck'),
            ),
            Spacer(flex: 10),
          ],
        ),
      ),
    ]);
  }
}
