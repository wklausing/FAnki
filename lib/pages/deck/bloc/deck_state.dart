part of 'deck_bloc.dart';

final class DeckState {
  const DeckState({
    this.isLoading = false,
  });

  final bool isLoading;

  DeckState copyWith({
    bool? isLoading,
  }) {
    return DeckState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
