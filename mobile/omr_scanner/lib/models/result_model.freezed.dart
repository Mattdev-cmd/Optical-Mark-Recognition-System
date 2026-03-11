// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StudentAnswer _$StudentAnswerFromJson(Map<String, dynamic> json) {
  return _StudentAnswer.fromJson(json);
}

/// @nodoc
mixin _$StudentAnswer {
  @JsonKey(name: 'question_number')
  int get questionNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_answer')
  String? get studentAnswer => throw _privateConstructorUsedError;
  @JsonKey(name: 'correct_answer')
  String get correctAnswer => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_correct')
  bool get isCorrect => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StudentAnswerCopyWith<StudentAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentAnswerCopyWith<$Res> {
  factory $StudentAnswerCopyWith(
          StudentAnswer value, $Res Function(StudentAnswer) then) =
      _$StudentAnswerCopyWithImpl<$Res, StudentAnswer>;
  @useResult
  $Res call(
      {@JsonKey(name: 'question_number') int questionNumber,
      @JsonKey(name: 'student_answer') String? studentAnswer,
      @JsonKey(name: 'correct_answer') String correctAnswer,
      @JsonKey(name: 'is_correct') bool isCorrect});
}

/// @nodoc
class _$StudentAnswerCopyWithImpl<$Res, $Val extends StudentAnswer>
    implements $StudentAnswerCopyWith<$Res> {
  _$StudentAnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionNumber = null,
    Object? studentAnswer = freezed,
    Object? correctAnswer = null,
    Object? isCorrect = null,
  }) {
    return _then(_value.copyWith(
      questionNumber: null == questionNumber
          ? _value.questionNumber
          : questionNumber // ignore: cast_nullable_to_non_nullable
              as int,
      studentAnswer: freezed == studentAnswer
          ? _value.studentAnswer
          : studentAnswer // ignore: cast_nullable_to_non_nullable
              as String?,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudentAnswerImplCopyWith<$Res>
    implements $StudentAnswerCopyWith<$Res> {
  factory _$$StudentAnswerImplCopyWith(
          _$StudentAnswerImpl value, $Res Function(_$StudentAnswerImpl) then) =
      __$$StudentAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'question_number') int questionNumber,
      @JsonKey(name: 'student_answer') String? studentAnswer,
      @JsonKey(name: 'correct_answer') String correctAnswer,
      @JsonKey(name: 'is_correct') bool isCorrect});
}

/// @nodoc
class __$$StudentAnswerImplCopyWithImpl<$Res>
    extends _$StudentAnswerCopyWithImpl<$Res, _$StudentAnswerImpl>
    implements _$$StudentAnswerImplCopyWith<$Res> {
  __$$StudentAnswerImplCopyWithImpl(
      _$StudentAnswerImpl _value, $Res Function(_$StudentAnswerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionNumber = null,
    Object? studentAnswer = freezed,
    Object? correctAnswer = null,
    Object? isCorrect = null,
  }) {
    return _then(_$StudentAnswerImpl(
      questionNumber: null == questionNumber
          ? _value.questionNumber
          : questionNumber // ignore: cast_nullable_to_non_nullable
              as int,
      studentAnswer: freezed == studentAnswer
          ? _value.studentAnswer
          : studentAnswer // ignore: cast_nullable_to_non_nullable
              as String?,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudentAnswerImpl implements _StudentAnswer {
  const _$StudentAnswerImpl(
      {@JsonKey(name: 'question_number') required this.questionNumber,
      @JsonKey(name: 'student_answer') this.studentAnswer,
      @JsonKey(name: 'correct_answer') required this.correctAnswer,
      @JsonKey(name: 'is_correct') required this.isCorrect});

  factory _$StudentAnswerImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentAnswerImplFromJson(json);

  @override
  @JsonKey(name: 'question_number')
  final int questionNumber;
  @override
  @JsonKey(name: 'student_answer')
  final String? studentAnswer;
  @override
  @JsonKey(name: 'correct_answer')
  final String correctAnswer;
  @override
  @JsonKey(name: 'is_correct')
  final bool isCorrect;

  @override
  String toString() {
    return 'StudentAnswer(questionNumber: $questionNumber, studentAnswer: $studentAnswer, correctAnswer: $correctAnswer, isCorrect: $isCorrect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentAnswerImpl &&
            (identical(other.questionNumber, questionNumber) ||
                other.questionNumber == questionNumber) &&
            (identical(other.studentAnswer, studentAnswer) ||
                other.studentAnswer == studentAnswer) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, questionNumber, studentAnswer, correctAnswer, isCorrect);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentAnswerImplCopyWith<_$StudentAnswerImpl> get copyWith =>
      __$$StudentAnswerImplCopyWithImpl<_$StudentAnswerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentAnswerImplToJson(
      this,
    );
  }
}

abstract class _StudentAnswer implements StudentAnswer {
  const factory _StudentAnswer(
          {@JsonKey(name: 'question_number') required final int questionNumber,
          @JsonKey(name: 'student_answer') final String? studentAnswer,
          @JsonKey(name: 'correct_answer') required final String correctAnswer,
          @JsonKey(name: 'is_correct') required final bool isCorrect}) =
      _$StudentAnswerImpl;

  factory _StudentAnswer.fromJson(Map<String, dynamic> json) =
      _$StudentAnswerImpl.fromJson;

  @override
  @JsonKey(name: 'question_number')
  int get questionNumber;
  @override
  @JsonKey(name: 'student_answer')
  String? get studentAnswer;
  @override
  @JsonKey(name: 'correct_answer')
  String get correctAnswer;
  @override
  @JsonKey(name: 'is_correct')
  bool get isCorrect;
  @override
  @JsonKey(ignore: true)
  _$$StudentAnswerImplCopyWith<_$StudentAnswerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScanResult _$ScanResultFromJson(Map<String, dynamic> json) {
  return _ScanResult.fromJson(json);
}

/// @nodoc
mixin _$ScanResult {
  @JsonKey(name: 'result_id')
  String get resultId => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_name')
  String get studentName => throw _privateConstructorUsedError;
  @JsonKey(name: 'exam_name')
  String get examName => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_questions')
  int get totalQuestions => throw _privateConstructorUsedError;
  @JsonKey(name: 'correct_answers')
  int get correctAnswers => throw _privateConstructorUsedError;
  @JsonKey(name: 'score_percentage')
  double get scorePercentage => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_answers')
  List<StudentAnswer> get studentAnswers => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScanResultCopyWith<ScanResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanResultCopyWith<$Res> {
  factory $ScanResultCopyWith(
          ScanResult value, $Res Function(ScanResult) then) =
      _$ScanResultCopyWithImpl<$Res, ScanResult>;
  @useResult
  $Res call(
      {@JsonKey(name: 'result_id') String resultId,
      @JsonKey(name: 'student_name') String studentName,
      @JsonKey(name: 'exam_name') String examName,
      @JsonKey(name: 'total_questions') int totalQuestions,
      @JsonKey(name: 'correct_answers') int correctAnswers,
      @JsonKey(name: 'score_percentage') double scorePercentage,
      @JsonKey(name: 'student_answers') List<StudentAnswer> studentAnswers,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$ScanResultCopyWithImpl<$Res, $Val extends ScanResult>
    implements $ScanResultCopyWith<$Res> {
  _$ScanResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultId = null,
    Object? studentName = null,
    Object? examName = null,
    Object? totalQuestions = null,
    Object? correctAnswers = null,
    Object? scorePercentage = null,
    Object? studentAnswers = null,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      resultId: null == resultId
          ? _value.resultId
          : resultId // ignore: cast_nullable_to_non_nullable
              as String,
      studentName: null == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String,
      examName: null == examName
          ? _value.examName
          : examName // ignore: cast_nullable_to_non_nullable
              as String,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswers: null == correctAnswers
          ? _value.correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      scorePercentage: null == scorePercentage
          ? _value.scorePercentage
          : scorePercentage // ignore: cast_nullable_to_non_nullable
              as double,
      studentAnswers: null == studentAnswers
          ? _value.studentAnswers
          : studentAnswers // ignore: cast_nullable_to_non_nullable
              as List<StudentAnswer>,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScanResultImplCopyWith<$Res>
    implements $ScanResultCopyWith<$Res> {
  factory _$$ScanResultImplCopyWith(
          _$ScanResultImpl value, $Res Function(_$ScanResultImpl) then) =
      __$$ScanResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'result_id') String resultId,
      @JsonKey(name: 'student_name') String studentName,
      @JsonKey(name: 'exam_name') String examName,
      @JsonKey(name: 'total_questions') int totalQuestions,
      @JsonKey(name: 'correct_answers') int correctAnswers,
      @JsonKey(name: 'score_percentage') double scorePercentage,
      @JsonKey(name: 'student_answers') List<StudentAnswer> studentAnswers,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$ScanResultImplCopyWithImpl<$Res>
    extends _$ScanResultCopyWithImpl<$Res, _$ScanResultImpl>
    implements _$$ScanResultImplCopyWith<$Res> {
  __$$ScanResultImplCopyWithImpl(
      _$ScanResultImpl _value, $Res Function(_$ScanResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultId = null,
    Object? studentName = null,
    Object? examName = null,
    Object? totalQuestions = null,
    Object? correctAnswers = null,
    Object? scorePercentage = null,
    Object? studentAnswers = null,
    Object? metadata = freezed,
  }) {
    return _then(_$ScanResultImpl(
      resultId: null == resultId
          ? _value.resultId
          : resultId // ignore: cast_nullable_to_non_nullable
              as String,
      studentName: null == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String,
      examName: null == examName
          ? _value.examName
          : examName // ignore: cast_nullable_to_non_nullable
              as String,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswers: null == correctAnswers
          ? _value.correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      scorePercentage: null == scorePercentage
          ? _value.scorePercentage
          : scorePercentage // ignore: cast_nullable_to_non_nullable
              as double,
      studentAnswers: null == studentAnswers
          ? _value._studentAnswers
          : studentAnswers // ignore: cast_nullable_to_non_nullable
              as List<StudentAnswer>,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScanResultImpl implements _ScanResult {
  const _$ScanResultImpl(
      {@JsonKey(name: 'result_id') required this.resultId,
      @JsonKey(name: 'student_name') required this.studentName,
      @JsonKey(name: 'exam_name') required this.examName,
      @JsonKey(name: 'total_questions') required this.totalQuestions,
      @JsonKey(name: 'correct_answers') required this.correctAnswers,
      @JsonKey(name: 'score_percentage') required this.scorePercentage,
      @JsonKey(name: 'student_answers')
      required final List<StudentAnswer> studentAnswers,
      final Map<String, dynamic>? metadata})
      : _studentAnswers = studentAnswers,
        _metadata = metadata;

  factory _$ScanResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScanResultImplFromJson(json);

  @override
  @JsonKey(name: 'result_id')
  final String resultId;
  @override
  @JsonKey(name: 'student_name')
  final String studentName;
  @override
  @JsonKey(name: 'exam_name')
  final String examName;
  @override
  @JsonKey(name: 'total_questions')
  final int totalQuestions;
  @override
  @JsonKey(name: 'correct_answers')
  final int correctAnswers;
  @override
  @JsonKey(name: 'score_percentage')
  final double scorePercentage;
  final List<StudentAnswer> _studentAnswers;
  @override
  @JsonKey(name: 'student_answers')
  List<StudentAnswer> get studentAnswers {
    if (_studentAnswers is EqualUnmodifiableListView) return _studentAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_studentAnswers);
  }

  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ScanResult(resultId: $resultId, studentName: $studentName, examName: $examName, totalQuestions: $totalQuestions, correctAnswers: $correctAnswers, scorePercentage: $scorePercentage, studentAnswers: $studentAnswers, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanResultImpl &&
            (identical(other.resultId, resultId) ||
                other.resultId == resultId) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.examName, examName) ||
                other.examName == examName) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.scorePercentage, scorePercentage) ||
                other.scorePercentage == scorePercentage) &&
            const DeepCollectionEquality()
                .equals(other._studentAnswers, _studentAnswers) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      resultId,
      studentName,
      examName,
      totalQuestions,
      correctAnswers,
      scorePercentage,
      const DeepCollectionEquality().hash(_studentAnswers),
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanResultImplCopyWith<_$ScanResultImpl> get copyWith =>
      __$$ScanResultImplCopyWithImpl<_$ScanResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScanResultImplToJson(
      this,
    );
  }
}

abstract class _ScanResult implements ScanResult {
  const factory _ScanResult(
      {@JsonKey(name: 'result_id') required final String resultId,
      @JsonKey(name: 'student_name') required final String studentName,
      @JsonKey(name: 'exam_name') required final String examName,
      @JsonKey(name: 'total_questions') required final int totalQuestions,
      @JsonKey(name: 'correct_answers') required final int correctAnswers,
      @JsonKey(name: 'score_percentage') required final double scorePercentage,
      @JsonKey(name: 'student_answers')
      required final List<StudentAnswer> studentAnswers,
      final Map<String, dynamic>? metadata}) = _$ScanResultImpl;

  factory _ScanResult.fromJson(Map<String, dynamic> json) =
      _$ScanResultImpl.fromJson;

  @override
  @JsonKey(name: 'result_id')
  String get resultId;
  @override
  @JsonKey(name: 'student_name')
  String get studentName;
  @override
  @JsonKey(name: 'exam_name')
  String get examName;
  @override
  @JsonKey(name: 'total_questions')
  int get totalQuestions;
  @override
  @JsonKey(name: 'correct_answers')
  int get correctAnswers;
  @override
  @JsonKey(name: 'score_percentage')
  double get scorePercentage;
  @override
  @JsonKey(name: 'student_answers')
  List<StudentAnswer> get studentAnswers;
  @override
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$ScanResultImplCopyWith<_$ScanResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ResultSummary _$ResultSummaryFromJson(Map<String, dynamic> json) {
  return _ResultSummary.fromJson(json);
}

/// @nodoc
mixin _$ResultSummary {
  @JsonKey(name: 'result_id')
  String get resultId => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_name')
  String get studentName => throw _privateConstructorUsedError;
  @JsonKey(name: 'exam_name')
  String get examName => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_questions')
  int get totalQuestions => throw _privateConstructorUsedError;
  @JsonKey(name: 'correct_answers')
  int get correctAnswers => throw _privateConstructorUsedError;
  String get percentage => throw _privateConstructorUsedError;
  @JsonKey(name: 'scanned_at')
  DateTime get scannedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResultSummaryCopyWith<ResultSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultSummaryCopyWith<$Res> {
  factory $ResultSummaryCopyWith(
          ResultSummary value, $Res Function(ResultSummary) then) =
      _$ResultSummaryCopyWithImpl<$Res, ResultSummary>;
  @useResult
  $Res call(
      {@JsonKey(name: 'result_id') String resultId,
      @JsonKey(name: 'student_name') String studentName,
      @JsonKey(name: 'exam_name') String examName,
      @JsonKey(name: 'total_questions') int totalQuestions,
      @JsonKey(name: 'correct_answers') int correctAnswers,
      String percentage,
      @JsonKey(name: 'scanned_at') DateTime scannedAt});
}

/// @nodoc
class _$ResultSummaryCopyWithImpl<$Res, $Val extends ResultSummary>
    implements $ResultSummaryCopyWith<$Res> {
  _$ResultSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultId = null,
    Object? studentName = null,
    Object? examName = null,
    Object? totalQuestions = null,
    Object? correctAnswers = null,
    Object? percentage = null,
    Object? scannedAt = null,
  }) {
    return _then(_value.copyWith(
      resultId: null == resultId
          ? _value.resultId
          : resultId // ignore: cast_nullable_to_non_nullable
              as String,
      studentName: null == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String,
      examName: null == examName
          ? _value.examName
          : examName // ignore: cast_nullable_to_non_nullable
              as String,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswers: null == correctAnswers
          ? _value.correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as String,
      scannedAt: null == scannedAt
          ? _value.scannedAt
          : scannedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResultSummaryImplCopyWith<$Res>
    implements $ResultSummaryCopyWith<$Res> {
  factory _$$ResultSummaryImplCopyWith(
          _$ResultSummaryImpl value, $Res Function(_$ResultSummaryImpl) then) =
      __$$ResultSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'result_id') String resultId,
      @JsonKey(name: 'student_name') String studentName,
      @JsonKey(name: 'exam_name') String examName,
      @JsonKey(name: 'total_questions') int totalQuestions,
      @JsonKey(name: 'correct_answers') int correctAnswers,
      String percentage,
      @JsonKey(name: 'scanned_at') DateTime scannedAt});
}

/// @nodoc
class __$$ResultSummaryImplCopyWithImpl<$Res>
    extends _$ResultSummaryCopyWithImpl<$Res, _$ResultSummaryImpl>
    implements _$$ResultSummaryImplCopyWith<$Res> {
  __$$ResultSummaryImplCopyWithImpl(
      _$ResultSummaryImpl _value, $Res Function(_$ResultSummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultId = null,
    Object? studentName = null,
    Object? examName = null,
    Object? totalQuestions = null,
    Object? correctAnswers = null,
    Object? percentage = null,
    Object? scannedAt = null,
  }) {
    return _then(_$ResultSummaryImpl(
      resultId: null == resultId
          ? _value.resultId
          : resultId // ignore: cast_nullable_to_non_nullable
              as String,
      studentName: null == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String,
      examName: null == examName
          ? _value.examName
          : examName // ignore: cast_nullable_to_non_nullable
              as String,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswers: null == correctAnswers
          ? _value.correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as String,
      scannedAt: null == scannedAt
          ? _value.scannedAt
          : scannedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResultSummaryImpl implements _ResultSummary {
  const _$ResultSummaryImpl(
      {@JsonKey(name: 'result_id') required this.resultId,
      @JsonKey(name: 'student_name') required this.studentName,
      @JsonKey(name: 'exam_name') required this.examName,
      @JsonKey(name: 'total_questions') required this.totalQuestions,
      @JsonKey(name: 'correct_answers') required this.correctAnswers,
      required this.percentage,
      @JsonKey(name: 'scanned_at') required this.scannedAt});

  factory _$ResultSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResultSummaryImplFromJson(json);

  @override
  @JsonKey(name: 'result_id')
  final String resultId;
  @override
  @JsonKey(name: 'student_name')
  final String studentName;
  @override
  @JsonKey(name: 'exam_name')
  final String examName;
  @override
  @JsonKey(name: 'total_questions')
  final int totalQuestions;
  @override
  @JsonKey(name: 'correct_answers')
  final int correctAnswers;
  @override
  final String percentage;
  @override
  @JsonKey(name: 'scanned_at')
  final DateTime scannedAt;

  @override
  String toString() {
    return 'ResultSummary(resultId: $resultId, studentName: $studentName, examName: $examName, totalQuestions: $totalQuestions, correctAnswers: $correctAnswers, percentage: $percentage, scannedAt: $scannedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResultSummaryImpl &&
            (identical(other.resultId, resultId) ||
                other.resultId == resultId) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.examName, examName) ||
                other.examName == examName) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.scannedAt, scannedAt) ||
                other.scannedAt == scannedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, resultId, studentName, examName,
      totalQuestions, correctAnswers, percentage, scannedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResultSummaryImplCopyWith<_$ResultSummaryImpl> get copyWith =>
      __$$ResultSummaryImplCopyWithImpl<_$ResultSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResultSummaryImplToJson(
      this,
    );
  }
}

abstract class _ResultSummary implements ResultSummary {
  const factory _ResultSummary(
          {@JsonKey(name: 'result_id') required final String resultId,
          @JsonKey(name: 'student_name') required final String studentName,
          @JsonKey(name: 'exam_name') required final String examName,
          @JsonKey(name: 'total_questions') required final int totalQuestions,
          @JsonKey(name: 'correct_answers') required final int correctAnswers,
          required final String percentage,
          @JsonKey(name: 'scanned_at') required final DateTime scannedAt}) =
      _$ResultSummaryImpl;

  factory _ResultSummary.fromJson(Map<String, dynamic> json) =
      _$ResultSummaryImpl.fromJson;

  @override
  @JsonKey(name: 'result_id')
  String get resultId;
  @override
  @JsonKey(name: 'student_name')
  String get studentName;
  @override
  @JsonKey(name: 'exam_name')
  String get examName;
  @override
  @JsonKey(name: 'total_questions')
  int get totalQuestions;
  @override
  @JsonKey(name: 'correct_answers')
  int get correctAnswers;
  @override
  String get percentage;
  @override
  @JsonKey(name: 'scanned_at')
  DateTime get scannedAt;
  @override
  @JsonKey(ignore: true)
  _$$ResultSummaryImplCopyWith<_$ResultSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
