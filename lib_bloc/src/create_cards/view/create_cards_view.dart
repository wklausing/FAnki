import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../create_cards.dart';

class CreateCardsView extends StatelessWidget {
  CreateCardsView({super.key});

  final frontController = TextEditingController();
  final backController = TextEditingController();

  void clearTextfields() {
    if (frontController.text.isNotEmpty || backController.text.isNotEmpty) {
      frontController.clear();
      backController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: BlocBuilder<CreateCardsCubit, CreateCardsState>(
            builder: (context, state) {
              if (state is CreateCardLoadingState) {
                return Column(
                  children: [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                    ElevatedButton.icon(
                      onPressed: () =>
                          context.read<CreateCardsCubit>().loadCardsOfDeck(),
                      icon: Icon(Icons.refresh, color: Colors.blue),
                      label: Text('Refresh'),
                    ),
                  ],
                );
              } else if (state is CreateCardEmptyState) {
                return Center(
                  child: Text('No cards.'),
                );
              } else if (state is CreateCardViewingState) {
                return ListView.builder(
                  itemCount: state.cards.length,
                  itemBuilder: (context, index) {
                    final card = state.cards[index];
                    return Card(
                      child: ListTile(
                        title: Text(card.questionText),
                        subtitle: Text(card.answerText),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context
                                .read<CreateCardsCubit>()
                                .removeCard(card.id);
                          },
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text('Error 634652'),
                );
              }
            },
          )),
          SizedBox(height: 16.0),
          TextField(
            controller: frontController,
            decoration: InputDecoration(
              labelText: 'Front',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: backController,
            decoration: InputDecoration(
              labelText: 'Back',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (frontController.text.isNotEmpty &&
                      backController.text.isNotEmpty) {
                    String question = frontController.text;
                    String answer = backController.text;
                    context.read<CreateCardsCubit>().addCard(question, answer);
                    clearTextfields();
                  }
                },
                child: Text('Save card'),
              ),
              SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  clearTextfields();
                },
                child: Text('Clear'),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
