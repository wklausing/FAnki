import 'package:anki_app/src/learning_page/bloc/learning_bloc.dart';
import 'package:anki_app/src/learning_page/bloc/learning_event.dart';
import 'package:anki_app/src/learning_page/view/learning_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => LearningBloc()..add(StartLearning()),
        child: const LearningPage(),
      ),
    );
  }
}
