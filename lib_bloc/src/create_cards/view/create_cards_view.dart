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
              if (state.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.cards.isEmpty) {
                return Center(
                  child: Text('No cards.'),
                );
              } else {
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
                            context.read<CreateCardsCubit>().removeCard(card);
                          },
                        ),
                      ),
                    );
                  },
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
                onPressed: clearTextfields,
                child: Text('Save card'),
              ),
              SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
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
