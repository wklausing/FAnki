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
  bool _showScrollDownButton = false;
  bool _showOverlayButtons = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    final isNearBottom = position.pixels >= position.maxScrollExtent - 200;

    // Show overlay buttons when near the bottom (viewing current card)
    if (_showOverlayButtons != isNearBottom) {
      setState(() {
        _showOverlayButtons = isNearBottom;
      });
    }

    // Show scroll-down button when scrolled up
    final showScrollButton = !isNearBottom;
    if (_showScrollDownButton != showScrollButton) {
      setState(() {
        _showScrollDownButton = showScrollButton;
      });
    }
  }

  void _scrollToCurrentCard(LearningLoadedState state) {
    if (!_scrollController.hasClients) return;

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  GlobalKey _getKeyForItem(int index) {
    return _itemKeys.putIfAbsent(index, () => GlobalKey());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fanki')),
      body: BlocBuilder<LearningBloc, LearningState>(
        builder: (context, state) {
          if (state is LearningLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LearningLoadedState) {
            // History + Current (no buttons in list)
            final itemCount = state.currentIndex + 1;

            return Stack(
              children: [
                ListView.separated(
                  controller: _scrollController,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                  itemCount: itemCount,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 32),
                  itemBuilder: (context, index) {
                    final card = state.cards[index];
                    final isCurrentCard = index == state.currentIndex;

                    return FlashcardWidget(
                      key: _getKeyForItem(index),
                      flashcard: card,
                      isAnswerShown: !isCurrentCard || state.isAnswerShown,
                      onTap: isCurrentCard && !state.isAnswerShown
                          ? () =>
                              context.read<LearningBloc>().add(RevealAnswer())
                          : null,
                    );
                  },
                ),
                // Overlay buttons that stay at bottom during transitions
                Positioned(
                  left: 32,
                  right: 32,
                  bottom: 32,
                  child: AnimatedOpacity(
                    opacity: _showOverlayButtons ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: _buildControls(context, state),
                  ),
                ),
                // Scroll-down button
                Positioned(
                  bottom: 110,
                  right: 16,
                  child: AnimatedOpacity(
                    opacity: _showScrollDownButton ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: FloatingActionButton.small(
                      onPressed: _showScrollDownButton
                          ? () => _scrollToCurrentCard(state)
                          : null,
                      child: const Icon(Icons.arrow_downward),
                    ),
                  ),
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
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => _handleButtonAction(context, state),
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100),
            child: const Text('Hard'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () => _handleButtonAction(context, state),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade100),
            child: const Text('Easy'),
          ),
        ),
      ],
    );
  }

  void _handleButtonAction(BuildContext context, LearningLoadedState state) {
    _scrollToCurrentCard(state);
    if (!state.isAnswerShown) {
      context.read<LearningBloc>().add(RevealAnswer());
    } else {
      context.read<LearningBloc>().add(NextCard());
    }
  }
}
