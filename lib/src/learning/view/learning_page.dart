import 'package:flutter/material.dart';
import 'learning_view.dart';

enum Difficulty { repeat, hard, good, easy }

class LearningPage extends StatelessWidget {
  const LearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LearningView();
  }
}
