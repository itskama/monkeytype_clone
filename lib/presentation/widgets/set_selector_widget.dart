import 'package:flutter/material.dart';
import 'package:monkeytype_clone/presentation/viewmodels/typing_viewmodel.dart';
import 'package:provider/provider.dart';

class SetSelectorWidget extends StatelessWidget {
  const SetSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TypingViewModel>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Выберите набор текстов:',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(4, (index) {
              final setNumber = index + 1;
              final isSelected = viewModel.currentSet == setNumber;

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    label: Text('Набор $setNumber'),
                    selected: isSelected,
                    onSelected: (_) {
                      viewModel.changeSet(setNumber);
                    },
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceVariant,
                    selectedColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(
            'Доступно текстов: ${viewModel.availableTexts.length}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
