import 'package:flutter/material.dart';
import 'package:monkeytype_clone/presentation/viewmodels/typing_viewmodel.dart';
import 'package:provider/provider.dart';

class TextDisplayWidget extends StatelessWidget {
  const TextDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TypingViewModel>();
    final text = viewModel.displayText;
    final input = viewModel.userInput;
    final correctnessList = viewModel.correctnessList;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Текст для набора:',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 12),
          _buildTextWithHighlighting(
            context,
            text,
            input,
            correctnessList,
            viewModel.isActive,
          ),
        ],
      ),
    );
  }

  Widget _buildTextWithHighlighting(
    BuildContext context,
    String originalText,
    String userInput,
    List<bool> correctnessList,
    bool isActive,
  ) {
    final textSpans = <TextSpan>[];
    final typedLength = userInput.length;

    // Обработанные символы
    for (int i = 0; i < typedLength; i++) {
      if (i < originalText.length) {
        final char = originalText[i];
        final isCorrect =
            i < correctnessList.length ? correctnessList[i] : false;

        textSpans.add(
          TextSpan(
            text: char,
            style: TextStyle(
              color: isCorrect
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.error,
              backgroundColor: isCorrect
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                  : Theme.of(context).colorScheme.error.withOpacity(0.1),
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        );
      }
    }

    // Необработанные символы
    if (typedLength < originalText.length) {
      final remainingText = originalText.substring(typedLength);
      textSpans.add(
        TextSpan(
          text: remainingText,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            fontSize: 18,
          ),
        ),
      );
    }

    // Курсор (мигающая анимация)
    if (typedLength < originalText.length && isActive) {
      final cursorChar = originalText[typedLength];
      textSpans.add(
        TextSpan(
          text: cursorChar,
          style: TextStyle(
            color: Colors.transparent,
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.3),
            fontSize: 18,
          ),
        ),
      );
    }

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style.copyWith(fontSize: 18),
        children: textSpans,
      ),
    );
  }
}
