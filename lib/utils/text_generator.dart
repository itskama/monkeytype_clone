import 'dart:math';
import 'package:monkeytype_clone/utils/constants.dart';
import 'package:monkeytype_clone/presentation/viewmodels/typing_viewmodel.dart';

class TextGenerator {
  static String getRandomText(Language language) {
    final random = Random();
    final List<String> texts = language == Language.en
        ? AppConstants.sampleTextsEn
        : AppConstants.sampleTextsRu;

    return texts[random.nextInt(texts.length)];
  }

  static String getDefaultText(Language language) {
    return language == Language.en
        ? AppConstants.defaultTextEn
        : AppConstants.defaultTextRu;
  }
}
