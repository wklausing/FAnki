import 'package:fanki/pages/create_card/create_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateCardPage extends StatefulWidget {
  const CreateCardPage({super.key});

  @override
  State<CreateCardPage> createState() => _CreateCardPageState();
}

class _CreateCardPageState extends State<CreateCardPage> {
  late final TextEditingController _questionTextEditingController;
  late final TextEditingController _answerTextEditingController;

  @override
  void initState() {
    super.initState();
    final state = context.read<CreateCardBloc>().state;
    _questionTextEditingController = TextEditingController(text: state.question);
    _answerTextEditingController = TextEditingController(text: state.answer);
  }

  @override
  void dispose() {
    _questionTextEditingController.dispose();
    _answerTextEditingController.dispose();
    super.dispose();
  }

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
            if (_questionTextEditingController.text != state.question) {
              _questionTextEditingController.text = state.question;
            }
            if (_answerTextEditingController.text != state.answer) {
              _answerTextEditingController.text = state.answer;
            }

            return Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Question',
                    border: OutlineInputBorder(),
                  ),
                  controller: _questionTextEditingController,
                  onChanged: (value) => context.read<CreateCardBloc>().add(QuestionChanged(question: value)),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Answer',
                    border: OutlineInputBorder(),
                  ),
                  controller: _answerTextEditingController,
                  onChanged: (value) => context.read<CreateCardBloc>().add(AnswerChanged(answer: value)),
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: state.cardIsValid
                          ? () {
                              context.read<CreateCardBloc>().add(CreateNewCard());
                              context.go('/HomeTabView/DeckPage');
                            }
                          : null,
                      child: const Text('Save Flashcard'),
                    ),
                    if (!state.isNewCard)
                      ElevatedButton(
                        onPressed: () {
                          context.read<CreateCardBloc>().add(RemoveCard(cardId: state.cardId));
                          context.go('/HomeTabView/DeckPage');
                        },
                        child: const Text('Delete Card'),
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
