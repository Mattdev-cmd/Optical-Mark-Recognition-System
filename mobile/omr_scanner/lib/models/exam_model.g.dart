// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnswerKeyImpl _$$AnswerKeyImplFromJson(Map<String, dynamic> json) =>
    _$AnswerKeyImpl(
      questionNumber: (json['question_number'] as num).toInt(),
      correctAnswer: json['correct_answer'] as String,
    );

Map<String, dynamic> _$$AnswerKeyImplToJson(_$AnswerKeyImpl instance) =>
    <String, dynamic>{
      'question_number': instance.questionNumber,
      'correct_answer': instance.correctAnswer,
    };

_$ExamImpl _$$ExamImplFromJson(Map<String, dynamic> json) => _$ExamImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      subject: json['subject'] as String?,
      totalQuestions: (json['total_questions'] as num).toInt(),
      choices:
          (json['choices'] as List<dynamic>).map((e) => e as String).toList(),
      answerKey: json['answer_key'] as List<dynamic>,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$ExamImplToJson(_$ExamImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subject': instance.subject,
      'total_questions': instance.totalQuestions,
      'choices': instance.choices,
      'answer_key': instance.answerKey,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_$ExamCreateRequestImpl _$$ExamCreateRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ExamCreateRequestImpl(
      name: json['name'] as String,
      subject: json['subject'] as String,
      totalQuestions: (json['total_questions'] as num).toInt(),
      choices:
          (json['choices'] as List<dynamic>).map((e) => e as String).toList(),
      answerKey: (json['answer_key'] as List<dynamic>)
          .map((e) => AnswerKey.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ExamCreateRequestImplToJson(
        _$ExamCreateRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'subject': instance.subject,
      'total_questions': instance.totalQuestions,
      'choices': instance.choices,
      'answer_key': instance.answerKey,
    };
