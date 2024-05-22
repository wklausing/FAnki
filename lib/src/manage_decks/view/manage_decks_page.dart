import 'package:flutter/material.dart';
import 'manage_decks_view.dart';

enum Difficulty { repeat, hard, good, easy }

class ManageDecksPage extends StatelessWidget {
  const ManageDecksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ManageDecksView();
  }
}
