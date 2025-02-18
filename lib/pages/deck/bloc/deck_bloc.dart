import 'package:bloc/bloc.dart';

part 'deck_event.dart';
part 'deck_state.dart';

class DeckBloc extends Bloc<DeckEvent, DeckState> {
  DeckBloc() : super(const DeckState()) {
    on<DeckRandomEvent>(_onUsernameChanged);
  }

  void _onUsernameChanged(
    DeckRandomEvent event,
    Emitter<DeckState> emit,
  ) {
    emit(
      state.copyWith(),
    );
  }
}
