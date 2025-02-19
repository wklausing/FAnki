part of 'settings_cubit.dart';

final class SettingsState {
  final bool isLoading;
  final UserModel? userModel;

  const SettingsState({
    this.isLoading = false,
    this.userModel,
  });

  SettingsState copyWith({
    bool? isLoading,
    UserModel? userModel,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      userModel: userModel ?? this.userModel,
    );
  }
}
