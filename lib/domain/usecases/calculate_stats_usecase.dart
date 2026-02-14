import 'package:monkeytype_clone/data/models/typing_model.dart';
import 'package:monkeytype_clone/domain/entities/typing_result.dart';

class CalculateStatsUseCase {
  TypingResult execute(TypingModel model) {
    return TypingResult(
      wpm: model.wpm,
      accuracy: model.accuracy,
      correctChars: model.correctChars,
      incorrectChars: model.incorrectChars,
      totalTimeSeconds: model.totalTimeSeconds,
    );
  }

  double calculateAccuracy(String original, String input) {
    if (input.isEmpty) return 100.0;
    
    int correct = 0;
    final minLength = original.length < input.length ? original.length : input.length;
    
    for (int i = 0; i < minLength; i++) {
      if (original[i] == input[i]) correct++;
    }
    
    return (correct / input.length) * 100;
  }

  int calculateWPM(int correctChars, int elapsedSeconds) {
    if (elapsedSeconds == 0) return 0;
    final minutes = elapsedSeconds / 60.0;
    final words = correctChars / 5.0;
    return (words / minutes).round();
  }
}