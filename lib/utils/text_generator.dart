import 'dart:math';
import 'package:monkeytype_clone/utils/constants.dart';

class TextGenerator {
  static String getRandomText() {
    final random = Random();
    return AppConstants.sampleTexts[
        random.nextInt(AppConstants.sampleTexts.length)];
  }

  static String getDefaultText() {
    return AppConstants.defaultText;
  }
}