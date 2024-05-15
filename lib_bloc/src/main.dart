import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'navigation_cubit.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => NavigationCubit(),
      child: FAnkiApp(),
    ),
  );
}
