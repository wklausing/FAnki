import 'package:fanki/pages/create_card/create_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateCardPage extends StatelessWidget {
  const CreateCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Flashcard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CreateCardBloc, CreateCardState>(
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Question',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => context.read<CreateCardBloc>().add(QuestionChanged(question: value)),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Answer',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => context.read<CreateCardBloc>().add(AnswerChanged(answer: value)),
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: state.cardIsValid
                      ? (() {
                          context.read<CreateCardBloc>().add(CreateNewCard());
                          context.go('/HomeTabView/DeckPage', extra: 'fe');
                        })
                      : null,
                  child: const Text('Save Flashcard'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
