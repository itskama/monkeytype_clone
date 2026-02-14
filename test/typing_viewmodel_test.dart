import 'package:flutter_test/flutter_test.dart';
import 'package:monkeytype_clone/presentation/viewmodels/typing_viewmodel.dart';

void main() {
  group('TypingViewModel Tests', () {
    late TypingViewModel viewModel;

    setUp(() {
      viewModel = TypingViewModel();
    });

    test('Initial state', () {
      expect(viewModel.isActive, false);
      expect(viewModel.userInput, isEmpty);
      expect(viewModel.remainingTime, greaterThan(0));
    });

    test('Start typing activates timer', () async {
      await viewModel.initializationDone;
      viewModel.startTyping();
      expect(viewModel.isActive, true);
    });

    test('Update input works correctly', () async {
      await viewModel.initializationDone;
      const testInput = 'test';
      viewModel.updateInput(testInput);
      expect(viewModel.userInput, testInput);
    });

    test('Accuracy calculation', () async {
      await viewModel.initializationDone;
      final original = viewModel.displayText;
      if (original.isNotEmpty) {
        viewModel.updateInput(original[0]);
        expect(viewModel.accuracy, 100.0);
      }
    });

    test('Reset test works', () async {
      await viewModel.initializationDone;
      final originalText = viewModel.displayText;
      viewModel.updateInput('test');
      viewModel.resetTest();
      await viewModel.initializationDone;
      
      expect(viewModel.userInput, isEmpty);
      expect(viewModel.displayText, isNot(originalText));
    });

    test('Timer completion', () async {
      await viewModel.initializationDone;
      viewModel.setTime(1); // Устанавливаем 1 секунду для теста
      viewModel.startTyping();
      
      await Future.delayed(const Duration(seconds: 2));
      
      expect(viewModel.isCompleted, true);
      expect(viewModel.isActive, false);
    });
  });
}