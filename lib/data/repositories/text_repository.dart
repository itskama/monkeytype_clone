import 'package:monkeytype_clone/utils/text_generator.dart';

class TextRepository {
  Future<String> getRandomText() async {
    // В будущем можно добавить загрузку из файла или API
    await Future.delayed(const Duration(milliseconds: 100));
    return TextGenerator.getRandomText();
  }

  String getDefaultText() {
    return TextGenerator.getDefaultText();
  }
}