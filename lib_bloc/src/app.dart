import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'learning/learning.dart';
import 'navigation_cubit.dart';
import 'create_cards/create_cards.dart';

class FAnkiApp extends StatelessWidget {
  const FAnkiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocListener<NavigationCubit, NavigationState>(
        listener: (context, state) {
          if (state == NavigationState.createCards) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CreateCardsPage()));
          } else if (state == NavigationState.learning) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
        child: LearningPage(),
      ),
    );
  }
}
