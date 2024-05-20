import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/learning_cubit.dart';

class LearningView extends StatelessWidget {
  const LearningView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Center(
          child: InkWell(
            onTap: () {
              print('InkWell tapped');
              context.read<LearningCubit>().toggleAnswerVisibility();
            },
            child: Container(
              width: 500,
              height: 300,
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BlocBuilder<LearningCubit, CardState>(
                    builder: (context, state) {
                      if (state is CardLearningState) {
                        return Text(
                          state.questionText,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        );
                      } else {
                        return Text('Wrong state 4345');
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Divider(color: Colors.transparent),
                  BlocBuilder<LearningCubit, CardState>(
                    builder: (context, state) {
                      if (state is CardLearningState) {
                        print(
                            'BlocBuilder state updated: ${state.answerIsVisible}');
                        return AnimatedOpacity(
                          opacity: state.answerIsVisible ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 300),
                          child: Text(
                            state.answerText,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        );
                      } else {
                        return Text('Wrong state 4564235753');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // if (context.read<LearningCubit>().state is CardLearningState) {
                //   context.read<LearningCubit>().fetchNextCard(1, 1);
                // } else {
                //   context.read<LearningCubit>().toggleAnswerVisibility();
                // }
              },
              child: const Text('Nochmal'),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                // if (context.read<LearningCubit>().state is CardLearningState) {
                //   context.read<LearningCubit>().fetchNextCard(1, 1);
                // } else {
                //   context.read<LearningCubit>().toggleAnswerVisibility();
                // }
              },
              child: const Text('Schwer'),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                // if (context.read<LearningCubit>().state is CardLearningState) {
                //   context.read<LearningCubit>().fetchNextCard(1, 1);
                // } else {
                //   context.read<LearningCubit>().toggleAnswerVisibility();
                // }
              },
              child: const Text('Gut'),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                // if (context.read<LearningCubit>().state is CardLearningState) {
                //   context.read<LearningCubit>().fetchNextCard(1, 1);
                // } else {
                //   context.read<LearningCubit>().toggleAnswerVisibility();
                // }
              },
              child: const Text('Einfach'),
            ),
          ],
        ),
      ],
    );
  }
}
