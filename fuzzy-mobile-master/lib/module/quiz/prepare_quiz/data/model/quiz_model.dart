import 'dart:convert';

class QuizModel {
  final String? questionId;
  final String? question;
  final String? answer;
  final String? option1;
  final String? option2;
  final String? option3;
  final String? option4;
  final int? poin;
  final String? type;
  final String? tips;

  QuizModel({
    this.questionId,
    this.question,
    this.answer,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.poin,
    this.type,
    this.tips,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        questionId: json['question_id'],
        question: json['question'],
        answer: json['answer'],
        option1: json['option1'],
        option2: json['option2'],
        option3: json['option3'],
        option4: json['option4'],
        poin: json['poin'],
        type: json['type'],
        tips: json['tips'],
      );

  factory QuizModel.fromRawJson(String str) => QuizModel.fromJson(json.decode(str));

  QuizModel copyWith({
    String? questionId,
    String? question,
    String? answer,
    String? option1,
    String? option2,
    String? option3,
    String? option4,
    int? poin,
    String? type,
    String? tips,
  }) =>
      QuizModel(
        questionId: questionId ?? this.questionId,
        question: question ?? this.question,
        answer: answer ?? this.answer,
        option1: option1 ?? this.option1,
        option2: option2 ?? this.option2,
        option3: option3 ?? this.option3,
        option4: option4 ?? this.option4,
        poin: poin ?? this.poin,
        type: type ?? this.type,
        tips: tips ?? this.tips,
      );

  Map<String, dynamic> toJson() => {
        'question_id': questionId,
        'question': question,
        'answer': answer,
        'option1': option1,
        'option2': option2,
        'option3': option3,
        'option4': option4,
        'poin': poin,
        'type': type,
        'tips': tips,
      };

  String toRawJson() => json.encode(toJson());
}
