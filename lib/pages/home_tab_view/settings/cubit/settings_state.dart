part of 'settings_cubit.dart';

final class SettingsState {
  const SettingsState({
    this.isLoading = true,
  });

  final bool isLoading;

  SettingsState copyWith({
    bool? isLoading,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
