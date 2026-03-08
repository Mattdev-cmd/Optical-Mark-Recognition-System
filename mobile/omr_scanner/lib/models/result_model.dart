import 'package:freezed_annotation/freezed_annotation.dart';

part 'result_model.freezed.dart';
part 'result_model.g.dart';

@freezed
class StudentAnswer with _$StudentAnswer {
  const factory StudentAnswer({
    @JsonKey(name: 'question_number') required int questionNumber,
    @JsonKey(name: 'student_answer') String? studentAnswer,
    @JsonKey(name: 'correct_answer') required String correctAnswer,
    @JsonKey(name: 'is_correct') required bool isCorrect,
  }) = _StudentAnswer;

  factory StudentAnswer.fromJson(Map<String, dynamic> json) =>
      _$StudentAnswerFromJson(json);
}

@freezed
class ScanResult with _$ScanResult {
  const factory ScanResult({
    @JsonKey(name: 'result_id') required String resultId,
    @JsonKey(name: 'student_name') required String studentName,
    @JsonKey(name: 'exam_name') required String examName,
    @JsonKey(name: 'total_questions') required int totalQuestions,
    @JsonKey(name: 'correct_answers') required int correctAnswers,
    required String score,
    required String percentage,
    @JsonKey(name: 'student_answers') required List<StudentAnswer> studentAnswers,
    required Map<String, dynamic> metadata,
  }) = _ScanResult;

  factory ScanResult.fromJson(Map<String, dynamic> json) =>
      _$ScanResultFromJson(json);
}

@freezed
class ResultSummary with _$ResultSummary {
  const factory ResultSummary({
    @JsonKey(name: 'result_id') required String resultId,
    @JsonKey(name: 'student_name') required String studentName,
    @JsonKey(name: 'exam_name') required String examName,
    @JsonKey(name: 'total_questions') required int totalQuestions,
    @JsonKey(name: 'correct_answers') required int correctAnswers,
    required String percentage,
    @JsonKey(name: 'scanned_at') required DateTime scannedAt,
  }) = _ResultSummary;

  factory ResultSummary.fromJson(Map<String, dynamic> json) =>
      _$ResultSummaryFromJson(json);
}
