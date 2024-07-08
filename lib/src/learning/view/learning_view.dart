import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/learning_cubit.dart';
import 'widgets.dart';

class LearningView extends StatelessWidget {
  const LearningView({super.key});

  @override
  Widget build(BuildContext context) {
    LearningCubit learningCubit = context.read<LearningCubit>();
    learningCubit.checkAndReloadDeck();
    return Column(
      children: [
        SizedBox(height: 8),
        Expanded(
          child: Center(
            child: buildLearningCardView(),
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => toggleOrAdvanceCard(learningCubit),
              child: const Text('Nochmal'),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => toggleOrAdvanceCard(learningCubit),
              child: const Text('Schwer'),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => toggleOrAdvanceCard(learningCubit),
              child: const Text('Gut'),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => toggleOrAdvanceCard(learningCubit),
              child: const Text('Einfach'),
            ),
          ],
        ),
        SizedBox(height: 50),
      ],
    );
  }

  void toggleOrAdvanceCard(LearningCubit cubit) {
    final state = cubit.state;

    if (state is CardLearningState) {
      if (state.answerIsVisible[0]) {
        cubit.nextCard();
      } else {
        cubit.toggleAnswerVisibility(0);
      }
    } else {
      cubit.toggleAnswerVisibility(0);
    }
  }
}
