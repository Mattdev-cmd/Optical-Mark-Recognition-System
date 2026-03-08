// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exam_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AnswerKey _$AnswerKeyFromJson(Map<String, dynamic> json) {
  return _AnswerKey.fromJson(json);
}

/// @nodoc
mixin _$AnswerKey {
  @JsonKey(name: 'question_number')
  int get questionNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'correct_answer')
  String get correctAnswer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnswerKeyCopyWith<AnswerKey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnswerKeyCopyWith<$Res> {
  factory $AnswerKeyCopyWith(AnswerKey value, $Res Function(AnswerKey) then) =
      _$AnswerKeyCopyWithImpl<$Res, AnswerKey>;
  @useResult
  $Res call(
      {@JsonKey(name: 'question_number') int questionNumber,
      @JsonKey(name: 'correct_answer') String correctAnswer});
}

/// @nodoc
class _$AnswerKeyCopyWithImpl<$Res, $Val extends AnswerKey>
    implements $AnswerKeyCopyWith<$Res> {
  _$AnswerKeyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionNumber = null,
    Object? correctAnswer = null,
  }) {
    return _then(_value.copyWith(
      questionNumber: null == questionNumber
          ? _value.questionNumber
          : questionNumber // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnswerKeyImplCopyWith<$Res>
    implements $AnswerKeyCopyWith<$Res> {
  factory _$$AnswerKeyImplCopyWith(
          _$AnswerKeyImpl value, $Res Function(_$AnswerKeyImpl) then) =
      __$$AnswerKeyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'question_number') int questionNumber,
      @JsonKey(name: 'correct_answer') String correctAnswer});
}

/// @nodoc
class __$$AnswerKeyImplCopyWithImpl<$Res>
    extends _$AnswerKeyCopyWithImpl<$Res, _$AnswerKeyImpl>
    implements _$$AnswerKeyImplCopyWith<$Res> {
  __$$AnswerKeyImplCopyWithImpl(
      _$AnswerKeyImpl _value, $Res Function(_$AnswerKeyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionNumber = null,
    Object? correctAnswer = null,
  }) {
    return _then(_$AnswerKeyImpl(
      questionNumber: null == questionNumber
          ? _value.questionNumber
          : questionNumber // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnswerKeyImpl implements _AnswerKey {
  const _$AnswerKeyImpl(
      {@JsonKey(name: 'question_number') required this.questionNumber,
      @JsonKey(name: 'correct_answer') required this.correctAnswer});

  factory _$AnswerKeyImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnswerKeyImplFromJson(json);

  @override
  @JsonKey(name: 'question_number')
  final int questionNumber;
  @override
  @JsonKey(name: 'correct_answer')
  final String correctAnswer;

  @override
  String toString() {
    return 'AnswerKey(questionNumber: $questionNumber, correctAnswer: $correctAnswer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnswerKeyImpl &&
            (identical(other.questionNumber, questionNumber) ||
                other.questionNumber == questionNumber) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, questionNumber, correctAnswer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnswerKeyImplCopyWith<_$AnswerKeyImpl> get copyWith =>
      __$$AnswerKeyImplCopyWithImpl<_$AnswerKeyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnswerKeyImplToJson(
      this,
    );
  }
}

abstract class _AnswerKey implements AnswerKey {
  const factory _AnswerKey(
      {@JsonKey(name: 'question_number') required final int questionNumber,
      @JsonKey(name: 'correct_answer')
      required final String correctAnswer}) = _$AnswerKeyImpl;

  factory _AnswerKey.fromJson(Map<String, dynamic> json) =
      _$AnswerKeyImpl.fromJson;

  @override
  @JsonKey(name: 'question_number')
  int get questionNumber;
  @override
  @JsonKey(name: 'correct_answer')
  String get correctAnswer;
  @override
  @JsonKey(ignore: true)
  _$$AnswerKeyImplCopyWith<_$AnswerKeyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Exam _$ExamFromJson(Map<String, dynamic> json) {
  return _Exam.fromJson(json);
}

/// @nodoc
mixin _$Exam {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get subject => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_questions')
  int get totalQuestions => throw _privateConstructorUsedError;
  List<String> get choices => throw _privateConstructorUsedError;
  @JsonKey(name: 'answer_key')
  List<dynamic> get answerKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExamCopyWith<Exam> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExamCopyWith<$Res> {
  factory $ExamCopyWith(Exam value, $Res Function(Exam) then) =
      _$ExamCopyWithImpl<$Res, Exam>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? subject,
      @JsonKey(name: 'total_questions') int totalQuestions,
      List<String> choices,
      @JsonKey(name: 'answer_key') List<dynamic> answerKey,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class _$ExamCopyWithImpl<$Res, $Val extends Exam>
    implements $ExamCopyWith<$Res> {
  _$ExamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? subject = freezed,
    Object? totalQuestions = null,
    Object? choices = null,
    Object? answerKey = null,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      choices: null == choices
          ? _value.choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<String>,
      answerKey: null == answerKey
          ? _value.answerKey
          : answerKey // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExamImplCopyWith<$Res> implements $ExamCopyWith<$Res> {
  factory _$$ExamImplCopyWith(
          _$ExamImpl value, $Res Function(_$ExamImpl) then) =
      __$$ExamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? subject,
      @JsonKey(name: 'total_questions') int totalQuestions,
      List<String> choices,
      @JsonKey(name: 'answer_key') List<dynamic> answerKey,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class __$$ExamImplCopyWithImpl<$Res>
    extends _$ExamCopyWithImpl<$Res, _$ExamImpl>
    implements _$$ExamImplCopyWith<$Res> {
  __$$ExamImplCopyWithImpl(_$ExamImpl _value, $Res Function(_$ExamImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? subject = freezed,
    Object? totalQuestions = null,
    Object? choices = null,
    Object? answerKey = null,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ExamImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      choices: null == choices
          ? _value._choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<String>,
      answerKey: null == answerKey
          ? _value._answerKey
          : answerKey // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExamImpl implements _Exam {
  const _$ExamImpl(
      {required this.id,
      required this.name,
      this.subject,
      @JsonKey(name: 'total_questions') required this.totalQuestions,
      required final List<String> choices,
      @JsonKey(name: 'answer_key') required final List<dynamic> answerKey,
      @JsonKey(name: 'created_by') this.createdBy,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt})
      : _choices = choices,
        _answerKey = answerKey;

  factory _$ExamImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExamImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? subject;
  @override
  @JsonKey(name: 'total_questions')
  final int totalQuestions;
  final List<String> _choices;
  @override
  List<String> get choices {
    if (_choices is EqualUnmodifiableListView) return _choices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_choices);
  }

  final List<dynamic> _answerKey;
  @override
  @JsonKey(name: 'answer_key')
  List<dynamic> get answerKey {
    if (_answerKey is EqualUnmodifiableListView) return _answerKey;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answerKey);
  }

  @override
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'Exam(id: $id, name: $name, subject: $subject, totalQuestions: $totalQuestions, choices: $choices, answerKey: $answerKey, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExamImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            const DeepCollectionEquality().equals(other._choices, _choices) &&
            const DeepCollectionEquality()
                .equals(other._answerKey, _answerKey) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      subject,
      totalQuestions,
      const DeepCollectionEquality().hash(_choices),
      const DeepCollectionEquality().hash(_answerKey),
      createdBy,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExamImplCopyWith<_$ExamImpl> get copyWith =>
      __$$ExamImplCopyWithImpl<_$ExamImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExamImplToJson(
      this,
    );
  }
}

abstract class _Exam implements Exam {
  const factory _Exam(
      {required final String id,
      required final String name,
      final String? subject,
      @JsonKey(name: 'total_questions') required final int totalQuestions,
      required final List<String> choices,
      @JsonKey(name: 'answer_key') required final List<dynamic> answerKey,
      @JsonKey(name: 'created_by') final String? createdBy,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt}) = _$ExamImpl;

  factory _Exam.fromJson(Map<String, dynamic> json) = _$ExamImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get subject;
  @override
  @JsonKey(name: 'total_questions')
  int get totalQuestions;
  @override
  List<String> get choices;
  @override
  @JsonKey(name: 'answer_key')
  List<dynamic> get answerKey;
  @override
  @JsonKey(name: 'created_by')
  String? get createdBy;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ExamImplCopyWith<_$ExamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExamCreateRequest _$ExamCreateRequestFromJson(Map<String, dynamic> json) {
  return _ExamCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$ExamCreateRequest {
  String get name => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_questions')
  int get totalQuestions => throw _privateConstructorUsedError;
  List<String> get choices => throw _privateConstructorUsedError;
  @JsonKey(name: 'answer_key')
  List<AnswerKey> get answerKey => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExamCreateRequestCopyWith<ExamCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExamCreateRequestCopyWith<$Res> {
  factory $ExamCreateRequestCopyWith(
          ExamCreateRequest value, $Res Function(ExamCreateRequest) then) =
      _$ExamCreateRequestCopyWithImpl<$Res, ExamCreateRequest>;
  @useResult
  $Res call(
      {String name,
      String subject,
      @JsonKey(name: 'total_questions') int totalQuestions,
      List<String> choices,
      @JsonKey(name: 'answer_key') List<AnswerKey> answerKey});
}

/// @nodoc
class _$ExamCreateRequestCopyWithImpl<$Res, $Val extends ExamCreateRequest>
    implements $ExamCreateRequestCopyWith<$Res> {
  _$ExamCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? subject = null,
    Object? totalQuestions = null,
    Object? choices = null,
    Object? answerKey = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      choices: null == choices
          ? _value.choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<String>,
      answerKey: null == answerKey
          ? _value.answerKey
          : answerKey // ignore: cast_nullable_to_non_nullable
              as List<AnswerKey>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExamCreateRequestImplCopyWith<$Res>
    implements $ExamCreateRequestCopyWith<$Res> {
  factory _$$ExamCreateRequestImplCopyWith(_$ExamCreateRequestImpl value,
          $Res Function(_$ExamCreateRequestImpl) then) =
      __$$ExamCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String subject,
      @JsonKey(name: 'total_questions') int totalQuestions,
      List<String> choices,
      @JsonKey(name: 'answer_key') List<AnswerKey> answerKey});
}

/// @nodoc
class __$$ExamCreateRequestImplCopyWithImpl<$Res>
    extends _$ExamCreateRequestCopyWithImpl<$Res, _$ExamCreateRequestImpl>
    implements _$$ExamCreateRequestImplCopyWith<$Res> {
  __$$ExamCreateRequestImplCopyWithImpl(_$ExamCreateRequestImpl _value,
      $Res Function(_$ExamCreateRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? subject = null,
    Object? totalQuestions = null,
    Object? choices = null,
    Object? answerKey = null,
  }) {
    return _then(_$ExamCreateRequestImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      choices: null == choices
          ? _value._choices
          : choices // ignore: cast_nullable_to_non_nullable
              as List<String>,
      answerKey: null == answerKey
          ? _value._answerKey
          : answerKey // ignore: cast_nullable_to_non_nullable
              as List<AnswerKey>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExamCreateRequestImpl implements _ExamCreateRequest {
  const _$ExamCreateRequestImpl(
      {required this.name,
      required this.subject,
      @JsonKey(name: 'total_questions') required this.totalQuestions,
      required final List<String> choices,
      @JsonKey(name: 'answer_key') required final List<AnswerKey> answerKey})
      : _choices = choices,
        _answerKey = answerKey;

  factory _$ExamCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExamCreateRequestImplFromJson(json);

  @override
  final String name;
  @override
  final String subject;
  @override
  @JsonKey(name: 'total_questions')
  final int totalQuestions;
  final List<String> _choices;
  @override
  List<String> get choices {
    if (_choices is EqualUnmodifiableListView) return _choices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_choices);
  }

  final List<AnswerKey> _answerKey;
  @override
  @JsonKey(name: 'answer_key')
  List<AnswerKey> get answerKey {
    if (_answerKey is EqualUnmodifiableListView) return _answerKey;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answerKey);
  }

  @override
  String toString() {
    return 'ExamCreateRequest(name: $name, subject: $subject, totalQuestions: $totalQuestions, choices: $choices, answerKey: $answerKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExamCreateRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            const DeepCollectionEquality().equals(other._choices, _choices) &&
            const DeepCollectionEquality()
                .equals(other._answerKey, _answerKey));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      subject,
      totalQuestions,
      const DeepCollectionEquality().hash(_choices),
      const DeepCollectionEquality().hash(_answerKey));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExamCreateRequestImplCopyWith<_$ExamCreateRequestImpl> get copyWith =>
      __$$ExamCreateRequestImplCopyWithImpl<_$ExamCreateRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExamCreateRequestImplToJson(
      this,
    );
  }
}

abstract class _ExamCreateRequest implements ExamCreateRequest {
  const factory _ExamCreateRequest(
      {required final String name,
      required final String subject,
      @JsonKey(name: 'total_questions') required final int totalQuestions,
      required final List<String> choices,
      @JsonKey(name: 'answer_key')
      required final List<AnswerKey> answerKey}) = _$ExamCreateRequestImpl;

  factory _ExamCreateRequest.fromJson(Map<String, dynamic> json) =
      _$ExamCreateRequestImpl.fromJson;

  @override
  String get name;
  @override
  String get subject;
  @override
  @JsonKey(name: 'total_questions')
  int get totalQuestions;
  @override
  List<String> get choices;
  @override
  @JsonKey(name: 'answer_key')
  List<AnswerKey> get answerKey;
  @override
  @JsonKey(ignore: true)
  _$$ExamCreateRequestImplCopyWith<_$ExamCreateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
