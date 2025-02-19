import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  AuthenticationRepository _authenticationRepository;

  SettingsCubit(
    super.initialState, {
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository {
    _initialize();
  }

  Future<void> _initialize() async {
    emit(state.copyWith(isLoading: true));

    UserModel userModel = _authenticationRepository.getUser();

    emit(state.copyWith(isLoading: false, userModel: userModel));
  }
}
