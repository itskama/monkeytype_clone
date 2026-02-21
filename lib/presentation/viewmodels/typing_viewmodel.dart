import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:monkeytype_clone/data/models/typing_model.dart';
import 'package:monkeytype_clone/data/repositories/text_repository.dart';
import 'package:monkeytype_clone/domain/usecases/calculate_stats_usecase.dart';
import 'package:monkeytype_clone/data/models/text_model.dart';
import 'package:monkeytype_clone/utils/constants.dart';

enum Language { ru, en }

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

  List<TextModel> _availableTexts = [];
  int _currentSet = 1;
  Language _currentLanguage = Language.ru;
  String _currentTextCategory = 'средний';

  TypingViewModel() {
    _initialize();
  }

  // ============= ГЕТТЕРЫ =============
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

  // Новые геттеры
  List<TextModel> get availableTexts => _availableTexts;
  int get currentSet => _currentSet;
  Language get currentLanguage => _currentLanguage;
  String get currentTextCategory => _currentTextCategory;

  Future<void> get initializationDone =>
      _initializationCompleter?.future ?? Future.value();

  // ============= МЕТОДЫ =============
  Future<void> _initialize() async {
    _initializationCompleter = Completer<void>();
    try {
      // Загружаем тексты для текущего языка
      await _loadTextsForLanguage(_currentLanguage);
      _initializationCompleter!.complete();
    } catch (e) {
      print('Ошибка инициализации: $e');
      // Используем текст по умолчанию
      _model = _model.copyWith(
        originalText: _currentLanguage == Language.ru
            ? AppConstants.defaultTextRu
            : AppConstants.defaultTextEn,
      );
      _initializationCompleter!.complete();
    }
    notifyListeners();
  }

  Future<void> _loadTextsForLanguage(Language language) async {
    if (language == Language.ru) {
      // Загружаем русские тексты из Firebase
      _availableTexts = await _textRepository.getTextsBySet(_currentSet);
      if (_availableTexts.isNotEmpty) {
        final randomText = _availableTexts[
            DateTime.now().millisecondsSinceEpoch % _availableTexts.length];
        _model = _model.copyWith(originalText: randomText.content);
        _currentTextCategory = randomText.category;
      } else {
        // Если нет в Firebase, используем локальные
        final texts = AppConstants.russianTextSets[_currentSet] ?? [];
        if (texts.isNotEmpty) {
          final randomIndex =
              DateTime.now().millisecondsSinceEpoch % texts.length;
          _model = _model.copyWith(originalText: texts[randomIndex]);
        }
      }
    } else {
      // Для английского используем локальные тексты
      final texts = AppConstants.englishTextSets[_currentSet] ?? [];
      if (texts.isNotEmpty) {
        final randomIndex =
            DateTime.now().millisecondsSinceEpoch % texts.length;
        _model = _model.copyWith(originalText: texts[randomIndex]);
      } else {
        _model = _model.copyWith(originalText: AppConstants.defaultTextEn);
      }
    }
  }

  Future<void> setLanguage(Language language) async {
    _currentLanguage = language;
    _currentSet = 1; // Сбрасываем на первый набор
    await _loadTextsForLanguage(language);
    notifyListeners();
  }

  Future<void> changeSet(int setNumber) async {
    if (setNumber < 1 || setNumber > 4) return;

    _currentSet = setNumber;
    await _loadTextsForLanguage(_currentLanguage);
    notifyListeners();
  }

  Future<void> loadRandomTextFromCurrentSet() async {
    await _loadTextsForLanguage(_currentLanguage);
    _model = _model.copyWith(
      userInput: '',
      isActive: false,
    );
    notifyListeners();
  }

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

    await _loadTextsForLanguage(_currentLanguage);

    _model = _model.copyWith(
      userInput: '',
      isActive: false,
      startTime: null,
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
