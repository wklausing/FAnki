import 'package:deck_repository/deck_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fanki/pages/deck_selection/deck_selection.dart';
import 'package:go_router/go_router.dart';

class DeckSelectionPage extends StatelessWidget {
  const DeckSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final deckRepository = context.read<DeckRepository>();
    return BlocProvider(
      create: (context) =>
          DeckSelectionBloc(deckRepository: deckRepository)..add(FetchDecks()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Deck Selection Page'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.go('/');
            },
          ),
        ),
        body: BlocBuilder<DeckSelectionBloc, DeckSelectionState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: state.decks.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(state.decks[index].title),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: 0 == index ? Colors.green : Colors.grey,
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.grey),
                          onPressed: () {
                            print("Really?");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
