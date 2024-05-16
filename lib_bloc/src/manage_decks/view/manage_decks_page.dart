import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/manage_decks_cubit.dart';
import 'manage_decks_view.dart';

enum Difficulty { repeat, hard, good, easy }

class ManageDecksPage extends StatelessWidget {
  const ManageDecksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ManageDecksCubit(),
      child: ManageDecksView(),
    );
  }
}
