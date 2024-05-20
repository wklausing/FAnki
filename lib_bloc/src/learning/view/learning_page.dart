import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../learning.dart';

enum Difficulty { repeat, hard, good, easy }

class LearningPage extends StatelessWidget {
  const LearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LearningCubit(),
      child: LearningView(),
    );
  }
}
