import 'package:card_repository/card_deck_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/learning_cubit.dart';

Widget buildLearningCardView() {
  return Container(
    alignment: Alignment.bottomCenter,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BlocBuilder<LearningCubit, CardLearnState>(
          builder: (context, state) {
            if (state is CardLearningState) {
              return listOfLearningCardsAnimated(context, state);
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
                child: Text('Error z45424326'),
              );
            }
          },
        ),
      ],
    ),
  );
}

Widget listOfLearningCardsAnimated(
    BuildContext context, CardLearningState state) {
  return Expanded(
    child: AnimatedList(
      reverse: true,
      key: state.animatedListKey,
      initialItemCount: state.cards.length,
      padding: EdgeInsets.all(4),
      itemBuilder: (context, index, animation) {
        SingleCard card = state.cards[index];
        return SizeTransition(
          sizeFactor: animation,
          child: FractionallySizedBox(
            widthFactor: 0.99,
            child: Card(
              shape: Border(),
              margin: EdgeInsets.all(4.0),
              child: InkWell(
                onTap: () =>
                    context.read<LearningCubit>().toggleAnswerVisibility(index),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card.questionText,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    AnimatedOpacity(
                      opacity: state.answerIsVisible[index] ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 0),
                      child: Text(
                        card.answerText,
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
