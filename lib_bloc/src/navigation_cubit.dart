import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationState { learning, createCards }

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState.learning);

  void goToCreateCards() => emit(NavigationState.createCards);

  void goToLearning() => emit(NavigationState.learning);
}
