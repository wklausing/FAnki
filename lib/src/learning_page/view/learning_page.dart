import 'package:anki_app/src/learning_page/bloc/learning_bloc.dart';
import 'package:anki_app/src/learning_page/bloc/learning_event.dart';
import 'package:anki_app/src/learning_page/bloc/learning_state.dart';
import 'package:anki_app/src/learning_page/view/flashcard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({super.key});

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _itemKeys = {};

  void _scrollToCurrentCard(int index) {
    final key = _itemKeys[index];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.0,
      );
    }
  }

  GlobalKey _getKeyForItem(int index) {
    return _itemKeys.putIfAbsent(index, () => GlobalKey());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learning Vocabulary')),
      body: BlocConsumer<LearningBloc, LearningState>(
        listener: (context, state) {
          if (state is LearningLoadedState && !state.isFinished) {
            // Small delay to ensure the widget is built and Key is available
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToCurrentCard(state.currentIndex);
            });
          }
        },
        builder: (context, state) {
          if (state is LearningLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LearningLoadedState) {
            final itemCount =
                state.isFinished ? state.cards.length : state.currentIndex + 1;

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    itemCount: itemCount,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 32),
                    itemBuilder: (context, index) {
                      final card = state.cards[index];
                      // Previous cards are always revealed.
                      // Current card is revealed depending on state.
                      final isCurrentCard = index == state.currentIndex;
                      final isRevealed = !isCurrentCard ||
                          state.isFinished ||
                          state.isAnswerShown;

                      return FlashcardWidget(
                        key: _getKeyForItem(index),
                        flashcard: card,
                        isAnswerShown: isRevealed,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: _buildControls(context, state),
                ),
              ],
            );
          } else {
            return const Center(child: Text('Something went wrong!'));
          }
        },
      ),
    );
  }

  Widget _buildControls(BuildContext context, LearningLoadedState state) {
    if (state.isFinished) {
      return Column(
        children: [
          const Text('All cards finished!'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<LearningBloc>().add(StartLearning());
            },
            child: const Text('Restart'),
          ),
        ],
      );
    } else if (state.isAnswerShown) {
      return ElevatedButton(
        onPressed: () {
          context.read<LearningBloc>().add(NextCard());
        },
        child: const Text('Next Card'),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          context.read<LearningBloc>().add(RevealAnswer());
        },
        child: const Text('Show Answer'),
      );
    }
  }
}
