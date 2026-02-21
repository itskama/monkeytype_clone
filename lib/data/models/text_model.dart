class TextModel {
  final String id;
  final String content;
  final int wordCount;
  final String category; // например: "легкий", "средний", "сложный"
  final int setNumber; // 1-4

  TextModel({
    required this.id,
    required this.content,
    required this.wordCount,
    required this.category,
    required this.setNumber,
  });

  factory TextModel.fromFirestore(Map<String, dynamic> data, String id) {
    return TextModel(
      id: id,
      content: data['content'] ?? '',
      wordCount: data['wordCount'] ?? 0,
      category: data['category'] ?? 'средний',
      setNumber: data['setNumber'] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'wordCount': wordCount,
      'category': category,
      'setNumber': setNumber,
    };
  }
}
