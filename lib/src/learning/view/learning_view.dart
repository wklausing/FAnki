import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/learning_cubit.dart';
import 'widgets.dart';

class LearningView extends StatelessWidget {
  LearningView({super.key});

  final GlobalKey<AnimatedListState> animatedListKey =
      GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    LearningCubit learningCubit = context.read<LearningCubit>();
    learningCubit.checkAndReloadDeck();
    return Column(
      children: [
        // Center(
        //   child: InkWell(
        //     onTap: () => {learningCubit.toggleAnswerVisibility()},
        //     child: learningCard(),
        //   ),
        // ),
        SizedBox(height: 8),
        Expanded(
          child: Center(
            child: buildLearningCardView(animatedListKey),
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
      if (state.answerIsVisible) {
        cubit.nextCard();
        animatedListKey.currentState?.insertItem(0);
      } else {
        cubit.toggleAnswerVisibility();
      }
    } else {
      cubit.toggleAnswerVisibility();
    }
  }
}
