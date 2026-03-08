import 'package:freezed_annotation/freezed_annotation.dart';

part 'exam_model.freezed.dart';
part 'exam_model.g.dart';

@freezed
class AnswerKey with _$AnswerKey {
  const factory AnswerKey({
    @JsonKey(name: 'question_number') required int questionNumber,
    @JsonKey(name: 'correct_answer') required String correctAnswer,
  }) = _AnswerKey;

  factory AnswerKey.fromJson(Map<String, dynamic> json) =>
      _$AnswerKeyFromJson(json);
}

@freezed
class Exam with _$Exam {
  const factory Exam({
    required String id,
    required String name,
    String? subject,
    @JsonKey(name: 'total_questions') required int totalQuestions,
    required List<String> choices,
    @JsonKey(name: 'answer_key') required List<dynamic> answerKey,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _Exam;

  factory Exam.fromJson(Map<String, dynamic> json) =>
      _$ExamFromJson(json);
}

@freezed
class ExamCreateRequest with _$ExamCreateRequest {
  const factory ExamCreateRequest({
    required String name,
    required String subject,
    @JsonKey(name: 'total_questions') required int totalQuestions,
    required List<String> choices,
    @JsonKey(name: 'answer_key') required List<AnswerKey> answerKey,
  }) = _ExamCreateRequest;

  factory ExamCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$ExamCreateRequestFromJson(json);
}
