part of 'create_card_bloc.dart';

final class CreateCardState {
  final bool isLoading;

  const CreateCardState({
    this.isLoading = false,
  });

  CreateCardState copyWith({
    bool? isLoading,
  }) {
    return CreateCardState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
