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
                        title: Text(state.decks[index].title),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                              ),
                              onPressed: () {
                                context.push('/HomeTabView/DeckPage');
                              },
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: null,
                  child: const Text('Create new deck'),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
