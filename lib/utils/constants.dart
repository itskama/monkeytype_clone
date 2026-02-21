// lib/utils/constants.dart

class AppConstants {
  static const int initialTimeSeconds = 30;
  static const int wpmCharsPerWord = 5;

  // Русские тексты (запасной вариант, если Firebase не работает)
  static const String defaultTextRu =
      "Программирование — это искусство создания решений для сложных проблем. "
      "Каждая строка кода приближает нас к пониманию технологий, которые окружают "
      "нас в повседневной жизни. Флаттер позволяет создавать красивые приложения "
      "для всех платформ из единой кодовой базы.";

  // Английские тексты (запасной вариант)
  static const String defaultTextEn =
      "Programming is the art of creating solutions for complex problems. "
      "Every line of code brings us closer to understanding the technologies "
      "that surround us in everyday life. Flutter allows you to create beautiful "
      "applications for all platforms from a single codebase.";

  // Примеры русских текстов для разных наборов
  static const List<String> sampleTextsRu = [
    "Быстрая коричневая лиса прыгает через ленивую собаку. Этот классический панграмма содержит все буквы русского алфавита и часто используется для проверки шрифтов и клавиатур.",
    "Программирование требует внимания к деталям и логического мышления. Хороший код должен быть не только рабочим, но и читаемым для других разработчиков.",
    "Флаттер использует язык Dart для создания кроссплатформенных приложений. Это позволяет писать один код для iOS, Android, веба и десктопа.",
    "Качество кода важнее количества строк. Читаемость превыше всего. Всегда следуйте лучшим практикам и стандартам оформления кода.",
    "Обучение — это постоянный процесс в мире технологий. Каждый день появляются новые инструменты, фреймворки и методологии разработки.",
  ];

  // Примеры английских текстов
  static const List<String> sampleTextsEn = [
    "The quick brown fox jumps over the lazy dog. This classic pangram contains every letter of the English alphabet and is often used for testing fonts and keyboards.",
    "Programming requires attention to detail and logical thinking. Good code should be not only functional but also readable for other developers.",
    "Flutter uses the Dart language to create cross-platform applications. This allows writing one code for iOS, Android, web, and desktop.",
    "Code quality is more important than the number of lines. Readability above all. Always follow best practices and coding standards.",
    "Learning is a constant process in the world of technology. Every day new tools, frameworks, and development methodologies appear.",
  ];

  // Наборы русских текстов по категориям
  static const Map<int, List<String>> russianTextSets = {
    1: [
      // Легкие тексты
      "Привет мир! Это простой текст для начинающих. Он содержит простые слова и короткие предложения.",
      "Сегодня хорошая погода. Солнце светит ярко. Птицы поют веселые песни.",
      "Я люблю программировать. Это очень интересно. Каждый день я узнаю что-то новое.",
    ],
    2: [
      // Средние тексты
      "Разработка программного обеспечения требует терпения и усидчивости. Важно уметь разбираться в сложных алгоритмах и структурах данных.",
      "Мобильные приложения стали неотъемлемой частью нашей жизни. Мы используем их для общения, работы и развлечений.",
    ],
    3: [
      // Сложные тексты
      "Оптимизация производительности критически важна для современных приложений. Необходимо учитывать множество факторов: от алгоритмов до работы с памятью.",
      "Архитектура чистой MVVM помогает разделить ответственность между компонентами и облегчает тестирование и поддержку кода.",
    ],
    4: [
      // Экспертные тексты
      "Асинхронное программирование в Dart основано на Future и Stream. Понимание этих концепций необходимо для создания отзывчивых приложений.",
      "Управление состоянием - одна из ключевых задач во Flutter. Provider и Riverpod предлагают элегантные решения для этой проблемы.",
    ],
  };

  // Наборы английских текстов
  static const Map<int, List<String>> englishTextSets = {
    1: [
      "Hello world! This is a simple text for beginners. It contains simple words and short sentences.",
      "Today is good weather. The sun is shining brightly. Birds are singing happy songs.",
    ],
    2: [
      "Software development requires patience and perseverance. It's important to understand complex algorithms and data structures.",
    ],
    3: [
      "Performance optimization is critical for modern applications. Many factors need to be considered: from algorithms to memory management.",
    ],
    4: [
      "Asynchronous programming in Dart is based on Future and Stream. Understanding these concepts is essential for creating responsive applications.",
    ],
  };
}
