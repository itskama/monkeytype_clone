import 'package:flutter/material.dart';
import 'package:monkeytype_clone/presentation/viewmodels/typing_viewmodel.dart';
import 'package:monkeytype_clone/presentation/widgets/text_display_widget.dart';
import 'package:monkeytype_clone/presentation/widgets/timer_widget.dart';
import 'package:monkeytype_clone/presentation/widgets/input_field_widget.dart';
import 'package:monkeytype_clone/presentation/widgets/stats_widget.dart';
import 'package:provider/provider.dart';

class TypingScreen extends StatefulWidget {
  const TypingScreen({super.key});

  @override
  State<TypingScreen> createState() => _TypingScreenState();
}

class _TypingScreenState extends State<TypingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModel = context.read<TypingViewModel>();
      await viewModel.initializationDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MonkeyType Clone'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<TypingViewModel>().resetTest();
            },
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: context.read<TypingViewModel>().initializationDone,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Consumer<TypingViewModel>(
            builder: (context, viewModel, child) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    TimerWidget(
                      time: viewModel.remainingTime,
                      totalTime: viewModel.totalTimeSeconds,
                      onTimeSelected: () {
                        _showTimeSelectionDialog(context, viewModel);
                      },
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextDisplayWidget(key: ValueKey(viewModel.displayText)),
                    ),
                    const SizedBox(height: 16),
                    InputFieldWidget(
                      onChanged: viewModel.updateInput,
                      isActive: viewModel.isActive,
                      isCompleted: viewModel.isCompleted,
                      initialValue: viewModel.userInput,
                    ),
                    const SizedBox(height: 16),
                    StatsWidget(
                      wpm: viewModel.wpm,
                      accuracy: viewModel.accuracy,
                      correctChars: viewModel.correctChars,
                      incorrectChars: viewModel.incorrectChars,
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: viewModel.resetTest,
                          icon: const Icon(Icons.restart_alt),
                          label: const Text('Начать заново'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (viewModel.isCompleted) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.celebration,
                              color: Theme.of(context).colorScheme.primary,
                              size: 32,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Тест завершен!',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color:
                                              Theme.of(context).colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    'Ваш результат: ${viewModel.wpm} зн/мин, '
                                    'точность: ${viewModel.accuracy.toStringAsFixed(1)}%',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 32),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showTimeSelectionDialog(BuildContext context, TypingViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Выберите время'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [15, 30, 60, 120].map((seconds) {
              return ListTile(
                title: Text('$seconds секунд'),
                trailing: viewModel.totalTimeSeconds == seconds
                    ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                    : null,
                onTap: () {
                  viewModel.setTime(seconds);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
          ],
        );
      },
    );
  }
}