import 'package:anki_app/src/learning_page/bloc/learning_bloc.dart';
import 'package:anki_app/src/learning_page/bloc/learning_event.dart';
import 'package:anki_app/src/learning_page/bloc/learning_state.dart';
import 'package:anki_app/src/learning_page/view/flashcard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LearningPage extends StatelessWidget {
  const LearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learning Vocabulary')),
      body: BlocBuilder<LearningBloc, LearningState>(
        builder: (context, state) {
          if (state is LearningLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LearningLoadedState) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: FlashcardWidget(
                      flashcard: state.currentCard,
                      isAnswerShown: state.isAnswerShown,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: state.isAnswerShown
                      ? ElevatedButton(
                          onPressed: () {
                            context.read<LearningBloc>().add(NextCard());
                          },
                          child: const Text('Next Card'),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            context.read<LearningBloc>().add(RevealAnswer());
                          },
                          child: const Text('Show Answer'),
                        ),
                ),
              ],
            );
          } else if (state is LearningFinishedState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('All cards finished!'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LearningBloc>().add(StartLearning());
                    },
                    child: const Text('Restart'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Something went wrong!'));
          }
        },
      ),
    );
  }
}
