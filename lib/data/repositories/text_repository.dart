import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monkeytype_clone/data/models/text_model.dart';

class TextRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'typing_texts';

  // Получить все тексты
  Future<List<TextModel>> getAllTexts() async {
    try {
      final snapshot = await _firestore.collection(collectionName).get();
      return snapshot.docs.map((doc) {
        return TextModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print('Ошибка загрузки текстов: $e');
      return [];
    }
  }

  // Получить тексты по номеру набора (1-4)
  Future<List<TextModel>> getTextsBySet(int setNumber) async {
    try {
      final snapshot = await _firestore.collection(collectionName).get();

      return snapshot.docs.map((doc) {
        return TextModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print('Ошибка загрузки текстов набора $setNumber: $e');
      return [];
    }
  }

  // Получить случайный текст
  Future<TextModel> getRandomText() async {
    try {
      final snapshot = await _firestore.collection(collectionName).get();
      final texts = snapshot.docs.map((doc) {
        return TextModel.fromFirestore(doc.data(), doc.id);
      }).toList();

      if (texts.isEmpty) {
        return _getDefaultText();
      }

      final randomIndex = DateTime.now().millisecondsSinceEpoch % texts.length;
      return texts[randomIndex];
    } catch (e) {
      print('Ошибка получения случайного текста: $e');
      return _getDefaultText();
    }
  }

  // Получить случайный текст из конкретного набора
  Future<TextModel> getRandomTextFromSet(int setNumber) async {
    try {
      final texts = await getTextsBySet(setNumber);
      if (texts.isEmpty) {
        return _getDefaultText();
      }
      final randomIndex = DateTime.now().millisecondsSinceEpoch % texts.length;
      return texts[randomIndex];
    } catch (e) {
      print('Ошибка: $e');
      return _getDefaultText();
    }
  }

  // Текст по умолчанию на случай ошибки
  TextModel _getDefaultText() {
    return TextModel(
      id: 'default',
      content:
          'Программирование — это искусство создания решений для сложных проблем. Каждая строка кода приближает нас к пониманию технологий, которые окружают нас в повседневной жизни.',
      wordCount: 25,
      category: 'средний',
      setNumber: 1,
    );
  }

  // Добавить текст (для администрирования)
  Future<void> addText(TextModel text) async {
    await _firestore.collection(collectionName).add(text.toMap());
  }

  // Добавить несколько текстов сразу
  Future<void> addMultipleTexts(List<TextModel> texts) async {
    final batch = _firestore.batch();
    for (var text in texts) {
      final docRef = _firestore.collection(collectionName).doc();
      batch.set(docRef, text.toMap());
    }
    await batch.commit();
  }
}
