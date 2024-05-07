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

  Widget listOfDecks(AppState appState) {
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
                trailing: appState.selectedDeckIndex == index
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : null,
                selected: appState.selectedDeckIndex == index,
                onTap: () {
                  appState.setSelectedDeckIndex(index);
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
        child: listOfDecks(appState),
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
