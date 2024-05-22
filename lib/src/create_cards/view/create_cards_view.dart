import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/create_cards_cubit.dart';

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
    context.read<CreateCardsCubit>().checkAndReloadDeck();
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
                  child: Text('Keine Karten im Stapel.'),
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
              labelText: 'Vorderseite',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: backController,
            decoration: InputDecoration(
              labelText: 'Rückseite',
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
                child: Text('Karte speichern'),
              ),
              SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  clearTextfields();
                },
                child: Text('Leeren'),
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
