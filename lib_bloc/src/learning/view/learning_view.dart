import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../learning.dart';
import '../cubit/learning_cubit.dart';

class LearningView extends StatelessWidget {
  const LearningView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LearningCubit>().checkAndReloadDeck();
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
                  BlocBuilder<LearningCubit, CardLearnState>(
                    builder: (context, state) {
                      if (state is CardLearningState) {
                        return Column(
                          children: [
                            Text(
                              state.questionText,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            SizedBox(height: 20),
                            Divider(color: Colors.transparent),
                            AnimatedOpacity(
                              opacity: state.answerIsVisible ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 0),
                              child: Text(
                                state.answerText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ],
                        );
                      } else if (state is CardLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is CardEmptyState) {
                        return Center(
                          child: Text('Keine Karten'),
                        );
                      } else {
                        return Center(
                          child: Text('Error'),
                        );
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
                fooCard(context.read<LearningCubit>());
              },
              child: const Text('Nochmal'),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                fooCard(context.read<LearningCubit>());
              },
              child: const Text('Schwer'),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                fooCard(context.read<LearningCubit>());
              },
              child: const Text('Gut'),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                fooCard(context.read<LearningCubit>());
              },
              child: const Text('Einfach'),
            ),
          ],
        ),
      ],
    );
  }

  void fooCard(LearningCubit cubit) {
    final state = cubit.state;

    if (state is CardLearningState) {
      if (state.answerIsVisible) {
        cubit.nextCard();
      } else {
        cubit.toggleAnswerVisibility();
      }
    } else {
      cubit.toggleAnswerVisibility();
    }
  }
}
