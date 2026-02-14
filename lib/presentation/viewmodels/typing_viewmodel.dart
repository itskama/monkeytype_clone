import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:monkeytype_clone/data/models/typing_model.dart';
import 'package:monkeytype_clone/data/repositories/text_repository.dart';
import 'package:monkeytype_clone/domain/usecases/calculate_stats_usecase.dart';

class TypingViewModel extends ChangeNotifier {
  final TextRepository _textRepository = TextRepository();
  final CalculateStatsUseCase _calculateStatsUseCase = CalculateStatsUseCase();
  
  TypingModel _model = TypingModel(
    originalText: '',
    userInput: '',
    isActive: false,
    totalTimeSeconds: 30,
  );
  
  Timer? _timer;
  Completer<void>? _initializationCompleter;

  TypingViewModel() {
    _initialize();
  }

  Future<void> _initialize() async {
    _initializationCompleter = Completer<void>();
    try {
      final text = await _textRepository.getRandomText();
      _model = _model.copyWith(originalText: text);
      notifyListeners();
      _initializationCompleter!.complete();
    } catch (e) {
      final defaultText = _textRepository.getDefaultText();
      _model = _model.copyWith(originalText: defaultText);
      notifyListeners();
      _initializationCompleter!.complete();
    }
  }

  // Геттеры для View
  String get displayText => _model.originalText;
  String get userInput => _model.userInput;
  int get remainingTime => _model.remainingTime;
  int get wpm => _model.wpm;
  double get accuracy => _model.accuracy;
  bool get isActive => _model.isActive;
  bool get isCompleted => _model.isCompleted;
  List<bool> get correctnessList => _model.correctnessList;
  int get correctChars => _model.correctChars;
  int get incorrectChars => _model.incorrectChars;
  int get totalTimeSeconds => _model.totalTimeSeconds;

  Future<void> get initializationDone => 
      _initializationCompleter?.future ?? Future.value();

  void startTyping() {
    if (_model.isActive || _model.isCompleted) return;
    
    _model = _model.copyWith(
      isActive: true,
      startTime: DateTime.now(),
    );
    
    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_model.remainingTime <= 0) {
        _timer?.cancel();
        _model = _model.copyWith(isActive: false);
        notifyListeners();
      } else {
        notifyListeners();
      }
    });
  }

  void updateInput(String text) {
    if (_model.isCompleted) return;
    
    if (!_model.isActive && text.isNotEmpty) {
      startTyping();
    }
    
    _model = _model.copyWith(userInput: text);
    notifyListeners();
  }

  Future<void> resetTest() async {
    _timer?.cancel();
    _timer = null;
    
    await initializationDone;
    final newText = await _textRepository.getRandomText();
    
    _model = TypingModel(
      originalText: newText,
      userInput: '',
      isActive: false,
      totalTimeSeconds: _model.totalTimeSeconds,
    );
    
    notifyListeners();
  }

  void setTime(int seconds) {
    _model = _model.copyWith(totalTimeSeconds: seconds);
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}