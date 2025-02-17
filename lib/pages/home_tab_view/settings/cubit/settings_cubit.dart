import 'package:bloc/bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(super.initialState);

  void foo(Emitter<SettingsState> emit) {
    emit(state.copyWith(isLoading: true));
    emit(state.copyWith(isLoading: false));
  }
}
