import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/create_cards_cubit.dart';
import 'create_cards_view.dart';

enum Difficulty { repeat, hard, good, easy }

class CreateCardsPage extends StatelessWidget {
  const CreateCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateCardsCubit(CreateCardsState()),
      child: CreateCardsView(),
    );
  }
}
