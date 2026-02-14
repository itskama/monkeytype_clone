class TypingResult {
  final int wpm;
  final double accuracy;
  final int correctChars;
  final int incorrectChars;
  final int totalTimeSeconds;

  const TypingResult({
    required this.wpm,
    required this.accuracy,
    required this.correctChars,
    required this.incorrectChars,
    required this.totalTimeSeconds,
  });

  @override
  String toString() {
    return 'WPM: $wpm, Accuracy: ${accuracy.toStringAsFixed(1)}%, '
        'Correct: $correctChars, Incorrect: $incorrectChars';
  }
}