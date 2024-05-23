import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/learning_cubit.dart';

Widget buildLearningCardView(GlobalKey<AnimatedListState> animatedListKey) {
  return Container(
    alignment: Alignment.bottomCenter,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BlocBuilder<LearningCubit, CardLearnState>(
          builder: (context, state) {
            if (state is CardLearningState) {
              return listOfLearningCardsAnimated(
                  context, state, animatedListKey);
            } else if (state is CardLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CardEmptyState) {
              return Center(child: Text('Keine Karten'));
            } else {
              return Center(child: Text('Error z45424326'));
            }
          },
        ),
      ],
    ),
  );
}

Widget listOfLearningCards(BuildContext context, CardLearningState state) {
  return Expanded(
    child: ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Card(
          shape: Border(),
          margin: EdgeInsets.all(4.0),
          child: InkWell(
            onTap: () => context.read<LearningCubit>().toggleAnswerVisibility(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.questionText,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                AnimatedOpacity(
                  opacity: state.answerIsVisible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 0),
                  child: Text(
                    state.answerText,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      padding: EdgeInsets.all(4),
    ),
  );
}

Widget listOfLearningCardsAnimated(BuildContext context,
    CardLearningState state, GlobalKey<AnimatedListState> animatedListKey) {
  return Expanded(
    child: AnimatedList(
      reverse: true,
      key: animatedListKey,
      initialItemCount: 1,
      padding: EdgeInsets.all(4),
      itemBuilder: (context, index, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: FractionallySizedBox(
            widthFactor: 0.99,
            child: Card(
              shape: Border(),
              margin: EdgeInsets.all(4.0),
              child: InkWell(
                onTap: () =>
                    context.read<LearningCubit>().toggleAnswerVisibility(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.questionText,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    AnimatedOpacity(
                      opacity: state.answerIsVisible ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 0),
                      child: Text(
                        state.answerText,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
