// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudentAnswerImpl _$$StudentAnswerImplFromJson(Map<String, dynamic> json) =>
    _$StudentAnswerImpl(
      questionNumber: (json['question_number'] as num).toInt(),
      studentAnswer: json['student_answer'] as String?,
      correctAnswer: json['correct_answer'] as String,
      isCorrect: json['is_correct'] as bool,
    );

Map<String, dynamic> _$$StudentAnswerImplToJson(_$StudentAnswerImpl instance) =>
    <String, dynamic>{
      'question_number': instance.questionNumber,
      'student_answer': instance.studentAnswer,
      'correct_answer': instance.correctAnswer,
      'is_correct': instance.isCorrect,
    };

_$ScanResultImpl _$$ScanResultImplFromJson(Map<String, dynamic> json) =>
    _$ScanResultImpl(
      resultId: json['result_id'] as String,
      studentName: json['student_name'] as String,
      examName: json['exam_name'] as String,
      totalQuestions: (json['total_questions'] as num).toInt(),
      correctAnswers: (json['correct_answers'] as num).toInt(),
      scorePercentage: (json['score_percentage'] as num).toDouble(),
      studentAnswers: (json['student_answers'] as List<dynamic>)
          .map((e) => StudentAnswer.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ScanResultImplToJson(_$ScanResultImpl instance) =>
    <String, dynamic>{
      'result_id': instance.resultId,
      'student_name': instance.studentName,
      'exam_name': instance.examName,
      'total_questions': instance.totalQuestions,
      'correct_answers': instance.correctAnswers,
      'score_percentage': instance.scorePercentage,
      'student_answers': instance.studentAnswers,
      'metadata': instance.metadata,
    };

_$ResultSummaryImpl _$$ResultSummaryImplFromJson(Map<String, dynamic> json) =>
    _$ResultSummaryImpl(
      resultId: json['result_id'] as String,
      studentName: json['student_name'] as String,
      examName: json['exam_name'] as String,
      totalQuestions: (json['total_questions'] as num).toInt(),
      correctAnswers: (json['correct_answers'] as num).toInt(),
      percentage: json['percentage'] as String,
      scannedAt: DateTime.parse(json['scanned_at'] as String),
    );

Map<String, dynamic> _$$ResultSummaryImplToJson(_$ResultSummaryImpl instance) =>
    <String, dynamic>{
      'result_id': instance.resultId,
      'student_name': instance.studentName,
      'exam_name': instance.examName,
      'total_questions': instance.totalQuestions,
      'correct_answers': instance.correctAnswers,
      'percentage': instance.percentage,
      'scanned_at': instance.scannedAt.toIso8601String(),
    };
