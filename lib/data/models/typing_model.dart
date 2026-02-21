import 'package:equatable/equatable.dart';
import '../../utils/constants.dart';

class TypingModel extends Equatable {
  final String originalText;
  final String userInput;
  final DateTime? startTime;
  final bool isActive;
  final int totalTimeSeconds;

  const TypingModel({
    required this.originalText,
    this.userInput = '',
    this.startTime,
    this.isActive = false,
    this.totalTimeSeconds = AppConstants.initialTimeSeconds,
  });

  TypingModel copyWith({
    String? originalText,
    String? userInput,
    DateTime? startTime,
    bool? isActive,
    int? totalTimeSeconds,
  }) {
    return TypingModel(
      originalText: originalText ?? this.originalText,
      userInput: userInput ?? this.userInput,
      startTime: startTime ?? this.startTime,
      isActive: isActive ?? this.isActive,
      totalTimeSeconds: totalTimeSeconds ?? this.totalTimeSeconds,
    );
  }

  int get elapsedSeconds {
    if (startTime == null) return 0;
    final now = DateTime.now();
    return now.difference(startTime!).inSeconds;
  }

  int get remainingTime {
    if (!isActive) return totalTimeSeconds;
    final elapsed = elapsedSeconds;
    return totalTimeSeconds - elapsed;
  }

  bool get isCompleted => remainingTime <= 0;

  List<bool> get correctnessList {
    final List<bool> correctness = [];
    for (int i = 0; i < userInput.length; i++) {
      if (i < originalText.length) {
        correctness.add(userInput[i] == originalText[i]);
      } else {
        correctness.add(false);
      }
    }
    return correctness;
  }

  int get correctChars {
    return correctnessList.where((isCorrect) => isCorrect).length;
  }

  int get incorrectChars {
    return correctnessList.where((isCorrect) => !isCorrect).length;
  }

  int get totalTypedChars => userInput.length;

  double get accuracy {
    if (totalTypedChars == 0) return 100.0;
    return (correctChars / totalTypedChars) * 100;
  }

  int get wpm {
    if (!isActive || elapsedSeconds == 0) return 0;
    final minutes = elapsedSeconds / 60.0;
    final words = correctChars / AppConstants.wpmCharsPerWord;
    return (words / minutes).round();
  }

  @override
  List<Object?> get props => [
        originalText,
        userInput,
        startTime,
        isActive,
        totalTimeSeconds,
      ];
}
