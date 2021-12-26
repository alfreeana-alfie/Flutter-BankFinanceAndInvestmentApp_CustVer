import 'package:flutter_banking_app/utils/string.dart';

class Question {
  int? id, status;
  String? locale, question, answer, createdAt;

  Question(
      {this.id,
      this.locale,
      this.question,
      this.answer,
      this.status,
      this.createdAt});

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
        id: map[Field.id] as int?,
        locale: map[Field.locale] as String?,
        question: map[Field.question] as String?,
        answer: map[Field.answer] as String?,
        status: map[Field.status] as int?,
        createdAt: map[Field.createdAt] as String?);
  }
}
