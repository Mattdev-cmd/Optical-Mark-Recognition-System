// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'classroom_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Classroom _$ClassroomFromJson(Map<String, dynamic> json) {
  return _Classroom.fromJson(json);
}

/// @nodoc
mixin _$Classroom {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get section => throw _privateConstructorUsedError;
  String? get grade => throw _privateConstructorUsedError;
  @JsonKey(name: 'academic_year')
  String? get academicYear => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_students')
  int? get maxStudents => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_count')
  int? get studentCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClassroomCopyWith<Classroom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassroomCopyWith<$Res> {
  factory $ClassroomCopyWith(Classroom value, $Res Function(Classroom) then) =
      _$ClassroomCopyWithImpl<$Res, Classroom>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String name,
      String? description,
      String? section,
      String? grade,
      @JsonKey(name: 'academic_year') String? academicYear,
      @JsonKey(name: 'max_students') int? maxStudents,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'student_count') int? studentCount,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$ClassroomCopyWithImpl<$Res, $Val extends Classroom>
    implements $ClassroomCopyWith<$Res> {
  _$ClassroomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? section = freezed,
    Object? grade = freezed,
    Object? academicYear = freezed,
    Object? maxStudents = freezed,
    Object? createdBy = freezed,
    Object? studentCount = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      section: freezed == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String?,
      grade: freezed == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYear: freezed == academicYear
          ? _value.academicYear
          : academicYear // ignore: cast_nullable_to_non_nullable
              as String?,
      maxStudents: freezed == maxStudents
          ? _value.maxStudents
          : maxStudents // ignore: cast_nullable_to_non_nullable
              as int?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      studentCount: freezed == studentCount
          ? _value.studentCount
          : studentCount // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClassroomImplCopyWith<$Res>
    implements $ClassroomCopyWith<$Res> {
  factory _$$ClassroomImplCopyWith(
          _$ClassroomImpl value, $Res Function(_$ClassroomImpl) then) =
      __$$ClassroomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String name,
      String? description,
      String? section,
      String? grade,
      @JsonKey(name: 'academic_year') String? academicYear,
      @JsonKey(name: 'max_students') int? maxStudents,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'student_count') int? studentCount,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$ClassroomImplCopyWithImpl<$Res>
    extends _$ClassroomCopyWithImpl<$Res, _$ClassroomImpl>
    implements _$$ClassroomImplCopyWith<$Res> {
  __$$ClassroomImplCopyWithImpl(
      _$ClassroomImpl _value, $Res Function(_$ClassroomImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? section = freezed,
    Object? grade = freezed,
    Object? academicYear = freezed,
    Object? maxStudents = freezed,
    Object? createdBy = freezed,
    Object? studentCount = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ClassroomImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      section: freezed == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String?,
      grade: freezed == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYear: freezed == academicYear
          ? _value.academicYear
          : academicYear // ignore: cast_nullable_to_non_nullable
              as String?,
      maxStudents: freezed == maxStudents
          ? _value.maxStudents
          : maxStudents // ignore: cast_nullable_to_non_nullable
              as int?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      studentCount: freezed == studentCount
          ? _value.studentCount
          : studentCount // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassroomImpl implements _Classroom {
  const _$ClassroomImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.name,
      this.description,
      this.section,
      this.grade,
      @JsonKey(name: 'academic_year') this.academicYear,
      @JsonKey(name: 'max_students') this.maxStudents,
      @JsonKey(name: 'created_by') this.createdBy,
      @JsonKey(name: 'student_count') this.studentCount,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$ClassroomImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassroomImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? section;
  @override
  final String? grade;
  @override
  @JsonKey(name: 'academic_year')
  final String? academicYear;
  @override
  @JsonKey(name: 'max_students')
  final int? maxStudents;
  @override
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @override
  @JsonKey(name: 'student_count')
  final int? studentCount;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Classroom(id: $id, name: $name, description: $description, section: $section, grade: $grade, academicYear: $academicYear, maxStudents: $maxStudents, createdBy: $createdBy, studentCount: $studentCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassroomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.academicYear, academicYear) ||
                other.academicYear == academicYear) &&
            (identical(other.maxStudents, maxStudents) ||
                other.maxStudents == maxStudents) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.studentCount, studentCount) ||
                other.studentCount == studentCount) &&
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
      description,
      section,
      grade,
      academicYear,
      maxStudents,
      createdBy,
      studentCount,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassroomImplCopyWith<_$ClassroomImpl> get copyWith =>
      __$$ClassroomImplCopyWithImpl<_$ClassroomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassroomImplToJson(
      this,
    );
  }
}

abstract class _Classroom implements Classroom {
  const factory _Classroom(
          {@JsonKey(name: '_id') required final String id,
          required final String name,
          final String? description,
          final String? section,
          final String? grade,
          @JsonKey(name: 'academic_year') final String? academicYear,
          @JsonKey(name: 'max_students') final int? maxStudents,
          @JsonKey(name: 'created_by') final String? createdBy,
          @JsonKey(name: 'student_count') final int? studentCount,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$ClassroomImpl;

  factory _Classroom.fromJson(Map<String, dynamic> json) =
      _$ClassroomImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get section;
  @override
  String? get grade;
  @override
  @JsonKey(name: 'academic_year')
  String? get academicYear;
  @override
  @JsonKey(name: 'max_students')
  int? get maxStudents;
  @override
  @JsonKey(name: 'created_by')
  String? get createdBy;
  @override
  @JsonKey(name: 'student_count')
  int? get studentCount;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ClassroomImplCopyWith<_$ClassroomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClassroomWithStudents _$ClassroomWithStudentsFromJson(
    Map<String, dynamic> json) {
  return _ClassroomWithStudents.fromJson(json);
}

/// @nodoc
mixin _$ClassroomWithStudents {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get section => throw _privateConstructorUsedError;
  String? get grade => throw _privateConstructorUsedError;
  @JsonKey(name: 'academic_year')
  String? get academicYear => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_students')
  int? get maxStudents => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_count')
  int get studentCount => throw _privateConstructorUsedError;
  List<StudentEnrollment> get students => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_exams')
  int get totalExams => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClassroomWithStudentsCopyWith<ClassroomWithStudents> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassroomWithStudentsCopyWith<$Res> {
  factory $ClassroomWithStudentsCopyWith(ClassroomWithStudents value,
          $Res Function(ClassroomWithStudents) then) =
      _$ClassroomWithStudentsCopyWithImpl<$Res, ClassroomWithStudents>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String name,
      String? description,
      String? section,
      String? grade,
      @JsonKey(name: 'academic_year') String? academicYear,
      @JsonKey(name: 'max_students') int? maxStudents,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'student_count') int studentCount,
      List<StudentEnrollment> students,
      @JsonKey(name: 'total_exams') int totalExams,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$ClassroomWithStudentsCopyWithImpl<$Res,
        $Val extends ClassroomWithStudents>
    implements $ClassroomWithStudentsCopyWith<$Res> {
  _$ClassroomWithStudentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? section = freezed,
    Object? grade = freezed,
    Object? academicYear = freezed,
    Object? maxStudents = freezed,
    Object? createdBy = freezed,
    Object? studentCount = null,
    Object? students = null,
    Object? totalExams = null,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      section: freezed == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String?,
      grade: freezed == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYear: freezed == academicYear
          ? _value.academicYear
          : academicYear // ignore: cast_nullable_to_non_nullable
              as String?,
      maxStudents: freezed == maxStudents
          ? _value.maxStudents
          : maxStudents // ignore: cast_nullable_to_non_nullable
              as int?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      studentCount: null == studentCount
          ? _value.studentCount
          : studentCount // ignore: cast_nullable_to_non_nullable
              as int,
      students: null == students
          ? _value.students
          : students // ignore: cast_nullable_to_non_nullable
              as List<StudentEnrollment>,
      totalExams: null == totalExams
          ? _value.totalExams
          : totalExams // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClassroomWithStudentsImplCopyWith<$Res>
    implements $ClassroomWithStudentsCopyWith<$Res> {
  factory _$$ClassroomWithStudentsImplCopyWith(
          _$ClassroomWithStudentsImpl value,
          $Res Function(_$ClassroomWithStudentsImpl) then) =
      __$$ClassroomWithStudentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String name,
      String? description,
      String? section,
      String? grade,
      @JsonKey(name: 'academic_year') String? academicYear,
      @JsonKey(name: 'max_students') int? maxStudents,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(name: 'student_count') int studentCount,
      List<StudentEnrollment> students,
      @JsonKey(name: 'total_exams') int totalExams,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$ClassroomWithStudentsImplCopyWithImpl<$Res>
    extends _$ClassroomWithStudentsCopyWithImpl<$Res,
        _$ClassroomWithStudentsImpl>
    implements _$$ClassroomWithStudentsImplCopyWith<$Res> {
  __$$ClassroomWithStudentsImplCopyWithImpl(_$ClassroomWithStudentsImpl _value,
      $Res Function(_$ClassroomWithStudentsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? section = freezed,
    Object? grade = freezed,
    Object? academicYear = freezed,
    Object? maxStudents = freezed,
    Object? createdBy = freezed,
    Object? studentCount = null,
    Object? students = null,
    Object? totalExams = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ClassroomWithStudentsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      section: freezed == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String?,
      grade: freezed == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYear: freezed == academicYear
          ? _value.academicYear
          : academicYear // ignore: cast_nullable_to_non_nullable
              as String?,
      maxStudents: freezed == maxStudents
          ? _value.maxStudents
          : maxStudents // ignore: cast_nullable_to_non_nullable
              as int?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      studentCount: null == studentCount
          ? _value.studentCount
          : studentCount // ignore: cast_nullable_to_non_nullable
              as int,
      students: null == students
          ? _value._students
          : students // ignore: cast_nullable_to_non_nullable
              as List<StudentEnrollment>,
      totalExams: null == totalExams
          ? _value.totalExams
          : totalExams // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassroomWithStudentsImpl implements _ClassroomWithStudents {
  const _$ClassroomWithStudentsImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.name,
      this.description,
      this.section,
      this.grade,
      @JsonKey(name: 'academic_year') this.academicYear,
      @JsonKey(name: 'max_students') this.maxStudents,
      @JsonKey(name: 'created_by') this.createdBy,
      @JsonKey(name: 'student_count') required this.studentCount,
      required final List<StudentEnrollment> students,
      @JsonKey(name: 'total_exams') required this.totalExams,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt})
      : _students = students;

  factory _$ClassroomWithStudentsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassroomWithStudentsImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? section;
  @override
  final String? grade;
  @override
  @JsonKey(name: 'academic_year')
  final String? academicYear;
  @override
  @JsonKey(name: 'max_students')
  final int? maxStudents;
  @override
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @override
  @JsonKey(name: 'student_count')
  final int studentCount;
  final List<StudentEnrollment> _students;
  @override
  List<StudentEnrollment> get students {
    if (_students is EqualUnmodifiableListView) return _students;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_students);
  }

  @override
  @JsonKey(name: 'total_exams')
  final int totalExams;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ClassroomWithStudents(id: $id, name: $name, description: $description, section: $section, grade: $grade, academicYear: $academicYear, maxStudents: $maxStudents, createdBy: $createdBy, studentCount: $studentCount, students: $students, totalExams: $totalExams, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassroomWithStudentsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.academicYear, academicYear) ||
                other.academicYear == academicYear) &&
            (identical(other.maxStudents, maxStudents) ||
                other.maxStudents == maxStudents) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.studentCount, studentCount) ||
                other.studentCount == studentCount) &&
            const DeepCollectionEquality().equals(other._students, _students) &&
            (identical(other.totalExams, totalExams) ||
                other.totalExams == totalExams) &&
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
      description,
      section,
      grade,
      academicYear,
      maxStudents,
      createdBy,
      studentCount,
      const DeepCollectionEquality().hash(_students),
      totalExams,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassroomWithStudentsImplCopyWith<_$ClassroomWithStudentsImpl>
      get copyWith => __$$ClassroomWithStudentsImplCopyWithImpl<
          _$ClassroomWithStudentsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassroomWithStudentsImplToJson(
      this,
    );
  }
}

abstract class _ClassroomWithStudents implements ClassroomWithStudents {
  const factory _ClassroomWithStudents(
          {@JsonKey(name: '_id') required final String id,
          required final String name,
          final String? description,
          final String? section,
          final String? grade,
          @JsonKey(name: 'academic_year') final String? academicYear,
          @JsonKey(name: 'max_students') final int? maxStudents,
          @JsonKey(name: 'created_by') final String? createdBy,
          @JsonKey(name: 'student_count') required final int studentCount,
          required final List<StudentEnrollment> students,
          @JsonKey(name: 'total_exams') required final int totalExams,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$ClassroomWithStudentsImpl;

  factory _ClassroomWithStudents.fromJson(Map<String, dynamic> json) =
      _$ClassroomWithStudentsImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get section;
  @override
  String? get grade;
  @override
  @JsonKey(name: 'academic_year')
  String? get academicYear;
  @override
  @JsonKey(name: 'max_students')
  int? get maxStudents;
  @override
  @JsonKey(name: 'created_by')
  String? get createdBy;
  @override
  @JsonKey(name: 'student_count')
  int get studentCount;
  @override
  List<StudentEnrollment> get students;
  @override
  @JsonKey(name: 'total_exams')
  int get totalExams;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ClassroomWithStudentsImplCopyWith<_$ClassroomWithStudentsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

StudentEnrollment _$StudentEnrollmentFromJson(Map<String, dynamic> json) {
  return _StudentEnrollment.fromJson(json);
}

/// @nodoc
mixin _$StudentEnrollment {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'exams_taken')
  int? get examsTaken => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_score')
  double? get averageScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'roll_number')
  String? get rollNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StudentEnrollmentCopyWith<StudentEnrollment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentEnrollmentCopyWith<$Res> {
  factory $StudentEnrollmentCopyWith(
          StudentEnrollment value, $Res Function(StudentEnrollment) then) =
      _$StudentEnrollmentCopyWithImpl<$Res, StudentEnrollment>;
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      @JsonKey(name: 'exams_taken') int? examsTaken,
      @JsonKey(name: 'average_score') double? averageScore,
      @JsonKey(name: 'roll_number') String? rollNumber});
}

/// @nodoc
class _$StudentEnrollmentCopyWithImpl<$Res, $Val extends StudentEnrollment>
    implements $StudentEnrollmentCopyWith<$Res> {
  _$StudentEnrollmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? examsTaken = freezed,
    Object? averageScore = freezed,
    Object? rollNumber = freezed,
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
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      examsTaken: freezed == examsTaken
          ? _value.examsTaken
          : examsTaken // ignore: cast_nullable_to_non_nullable
              as int?,
      averageScore: freezed == averageScore
          ? _value.averageScore
          : averageScore // ignore: cast_nullable_to_non_nullable
              as double?,
      rollNumber: freezed == rollNumber
          ? _value.rollNumber
          : rollNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudentEnrollmentImplCopyWith<$Res>
    implements $StudentEnrollmentCopyWith<$Res> {
  factory _$$StudentEnrollmentImplCopyWith(_$StudentEnrollmentImpl value,
          $Res Function(_$StudentEnrollmentImpl) then) =
      __$$StudentEnrollmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      @JsonKey(name: 'exams_taken') int? examsTaken,
      @JsonKey(name: 'average_score') double? averageScore,
      @JsonKey(name: 'roll_number') String? rollNumber});
}

/// @nodoc
class __$$StudentEnrollmentImplCopyWithImpl<$Res>
    extends _$StudentEnrollmentCopyWithImpl<$Res, _$StudentEnrollmentImpl>
    implements _$$StudentEnrollmentImplCopyWith<$Res> {
  __$$StudentEnrollmentImplCopyWithImpl(_$StudentEnrollmentImpl _value,
      $Res Function(_$StudentEnrollmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? examsTaken = freezed,
    Object? averageScore = freezed,
    Object? rollNumber = freezed,
  }) {
    return _then(_$StudentEnrollmentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      examsTaken: freezed == examsTaken
          ? _value.examsTaken
          : examsTaken // ignore: cast_nullable_to_non_nullable
              as int?,
      averageScore: freezed == averageScore
          ? _value.averageScore
          : averageScore // ignore: cast_nullable_to_non_nullable
              as double?,
      rollNumber: freezed == rollNumber
          ? _value.rollNumber
          : rollNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudentEnrollmentImpl implements _StudentEnrollment {
  const _$StudentEnrollmentImpl(
      {required this.id,
      required this.name,
      required this.email,
      @JsonKey(name: 'exams_taken') this.examsTaken,
      @JsonKey(name: 'average_score') this.averageScore,
      @JsonKey(name: 'roll_number') this.rollNumber});

  factory _$StudentEnrollmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentEnrollmentImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  @JsonKey(name: 'exams_taken')
  final int? examsTaken;
  @override
  @JsonKey(name: 'average_score')
  final double? averageScore;
  @override
  @JsonKey(name: 'roll_number')
  final String? rollNumber;

  @override
  String toString() {
    return 'StudentEnrollment(id: $id, name: $name, email: $email, examsTaken: $examsTaken, averageScore: $averageScore, rollNumber: $rollNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentEnrollmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.examsTaken, examsTaken) ||
                other.examsTaken == examsTaken) &&
            (identical(other.averageScore, averageScore) ||
                other.averageScore == averageScore) &&
            (identical(other.rollNumber, rollNumber) ||
                other.rollNumber == rollNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, email, examsTaken, averageScore, rollNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentEnrollmentImplCopyWith<_$StudentEnrollmentImpl> get copyWith =>
      __$$StudentEnrollmentImplCopyWithImpl<_$StudentEnrollmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentEnrollmentImplToJson(
      this,
    );
  }
}

abstract class _StudentEnrollment implements StudentEnrollment {
  const factory _StudentEnrollment(
          {required final String id,
          required final String name,
          required final String email,
          @JsonKey(name: 'exams_taken') final int? examsTaken,
          @JsonKey(name: 'average_score') final double? averageScore,
          @JsonKey(name: 'roll_number') final String? rollNumber}) =
      _$StudentEnrollmentImpl;

  factory _StudentEnrollment.fromJson(Map<String, dynamic> json) =
      _$StudentEnrollmentImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  @JsonKey(name: 'exams_taken')
  int? get examsTaken;
  @override
  @JsonKey(name: 'average_score')
  double? get averageScore;
  @override
  @JsonKey(name: 'roll_number')
  String? get rollNumber;
  @override
  @JsonKey(ignore: true)
  _$$StudentEnrollmentImplCopyWith<_$StudentEnrollmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClassroomStats _$ClassroomStatsFromJson(Map<String, dynamic> json) {
  return _ClassroomStats.fromJson(json);
}

/// @nodoc
mixin _$ClassroomStats {
  @JsonKey(name: 'classroom_id')
  String get classroomId => throw _privateConstructorUsedError;
  @JsonKey(name: 'classroom_name')
  String get classroomName => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_students')
  int get totalStudents => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_exams')
  int get totalExams => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_class_score')
  double get averageClassScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'highest_score')
  double get highestScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'lowest_score')
  double get lowestScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'students_passed')
  int get studentsPassed => throw _privateConstructorUsedError;
  @JsonKey(name: 'pass_percentage')
  double get passPercentage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClassroomStatsCopyWith<ClassroomStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassroomStatsCopyWith<$Res> {
  factory $ClassroomStatsCopyWith(
          ClassroomStats value, $Res Function(ClassroomStats) then) =
      _$ClassroomStatsCopyWithImpl<$Res, ClassroomStats>;
  @useResult
  $Res call(
      {@JsonKey(name: 'classroom_id') String classroomId,
      @JsonKey(name: 'classroom_name') String classroomName,
      @JsonKey(name: 'total_students') int totalStudents,
      @JsonKey(name: 'total_exams') int totalExams,
      @JsonKey(name: 'average_class_score') double averageClassScore,
      @JsonKey(name: 'highest_score') double highestScore,
      @JsonKey(name: 'lowest_score') double lowestScore,
      @JsonKey(name: 'students_passed') int studentsPassed,
      @JsonKey(name: 'pass_percentage') double passPercentage});
}

/// @nodoc
class _$ClassroomStatsCopyWithImpl<$Res, $Val extends ClassroomStats>
    implements $ClassroomStatsCopyWith<$Res> {
  _$ClassroomStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? classroomId = null,
    Object? classroomName = null,
    Object? totalStudents = null,
    Object? totalExams = null,
    Object? averageClassScore = null,
    Object? highestScore = null,
    Object? lowestScore = null,
    Object? studentsPassed = null,
    Object? passPercentage = null,
  }) {
    return _then(_value.copyWith(
      classroomId: null == classroomId
          ? _value.classroomId
          : classroomId // ignore: cast_nullable_to_non_nullable
              as String,
      classroomName: null == classroomName
          ? _value.classroomName
          : classroomName // ignore: cast_nullable_to_non_nullable
              as String,
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
      totalExams: null == totalExams
          ? _value.totalExams
          : totalExams // ignore: cast_nullable_to_non_nullable
              as int,
      averageClassScore: null == averageClassScore
          ? _value.averageClassScore
          : averageClassScore // ignore: cast_nullable_to_non_nullable
              as double,
      highestScore: null == highestScore
          ? _value.highestScore
          : highestScore // ignore: cast_nullable_to_non_nullable
              as double,
      lowestScore: null == lowestScore
          ? _value.lowestScore
          : lowestScore // ignore: cast_nullable_to_non_nullable
              as double,
      studentsPassed: null == studentsPassed
          ? _value.studentsPassed
          : studentsPassed // ignore: cast_nullable_to_non_nullable
              as int,
      passPercentage: null == passPercentage
          ? _value.passPercentage
          : passPercentage // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClassroomStatsImplCopyWith<$Res>
    implements $ClassroomStatsCopyWith<$Res> {
  factory _$$ClassroomStatsImplCopyWith(_$ClassroomStatsImpl value,
          $Res Function(_$ClassroomStatsImpl) then) =
      __$$ClassroomStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'classroom_id') String classroomId,
      @JsonKey(name: 'classroom_name') String classroomName,
      @JsonKey(name: 'total_students') int totalStudents,
      @JsonKey(name: 'total_exams') int totalExams,
      @JsonKey(name: 'average_class_score') double averageClassScore,
      @JsonKey(name: 'highest_score') double highestScore,
      @JsonKey(name: 'lowest_score') double lowestScore,
      @JsonKey(name: 'students_passed') int studentsPassed,
      @JsonKey(name: 'pass_percentage') double passPercentage});
}

/// @nodoc
class __$$ClassroomStatsImplCopyWithImpl<$Res>
    extends _$ClassroomStatsCopyWithImpl<$Res, _$ClassroomStatsImpl>
    implements _$$ClassroomStatsImplCopyWith<$Res> {
  __$$ClassroomStatsImplCopyWithImpl(
      _$ClassroomStatsImpl _value, $Res Function(_$ClassroomStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? classroomId = null,
    Object? classroomName = null,
    Object? totalStudents = null,
    Object? totalExams = null,
    Object? averageClassScore = null,
    Object? highestScore = null,
    Object? lowestScore = null,
    Object? studentsPassed = null,
    Object? passPercentage = null,
  }) {
    return _then(_$ClassroomStatsImpl(
      classroomId: null == classroomId
          ? _value.classroomId
          : classroomId // ignore: cast_nullable_to_non_nullable
              as String,
      classroomName: null == classroomName
          ? _value.classroomName
          : classroomName // ignore: cast_nullable_to_non_nullable
              as String,
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
      totalExams: null == totalExams
          ? _value.totalExams
          : totalExams // ignore: cast_nullable_to_non_nullable
              as int,
      averageClassScore: null == averageClassScore
          ? _value.averageClassScore
          : averageClassScore // ignore: cast_nullable_to_non_nullable
              as double,
      highestScore: null == highestScore
          ? _value.highestScore
          : highestScore // ignore: cast_nullable_to_non_nullable
              as double,
      lowestScore: null == lowestScore
          ? _value.lowestScore
          : lowestScore // ignore: cast_nullable_to_non_nullable
              as double,
      studentsPassed: null == studentsPassed
          ? _value.studentsPassed
          : studentsPassed // ignore: cast_nullable_to_non_nullable
              as int,
      passPercentage: null == passPercentage
          ? _value.passPercentage
          : passPercentage // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassroomStatsImpl implements _ClassroomStats {
  const _$ClassroomStatsImpl(
      {@JsonKey(name: 'classroom_id') required this.classroomId,
      @JsonKey(name: 'classroom_name') required this.classroomName,
      @JsonKey(name: 'total_students') required this.totalStudents,
      @JsonKey(name: 'total_exams') required this.totalExams,
      @JsonKey(name: 'average_class_score') required this.averageClassScore,
      @JsonKey(name: 'highest_score') required this.highestScore,
      @JsonKey(name: 'lowest_score') required this.lowestScore,
      @JsonKey(name: 'students_passed') required this.studentsPassed,
      @JsonKey(name: 'pass_percentage') required this.passPercentage});

  factory _$ClassroomStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassroomStatsImplFromJson(json);

  @override
  @JsonKey(name: 'classroom_id')
  final String classroomId;
  @override
  @JsonKey(name: 'classroom_name')
  final String classroomName;
  @override
  @JsonKey(name: 'total_students')
  final int totalStudents;
  @override
  @JsonKey(name: 'total_exams')
  final int totalExams;
  @override
  @JsonKey(name: 'average_class_score')
  final double averageClassScore;
  @override
  @JsonKey(name: 'highest_score')
  final double highestScore;
  @override
  @JsonKey(name: 'lowest_score')
  final double lowestScore;
  @override
  @JsonKey(name: 'students_passed')
  final int studentsPassed;
  @override
  @JsonKey(name: 'pass_percentage')
  final double passPercentage;

  @override
  String toString() {
    return 'ClassroomStats(classroomId: $classroomId, classroomName: $classroomName, totalStudents: $totalStudents, totalExams: $totalExams, averageClassScore: $averageClassScore, highestScore: $highestScore, lowestScore: $lowestScore, studentsPassed: $studentsPassed, passPercentage: $passPercentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassroomStatsImpl &&
            (identical(other.classroomId, classroomId) ||
                other.classroomId == classroomId) &&
            (identical(other.classroomName, classroomName) ||
                other.classroomName == classroomName) &&
            (identical(other.totalStudents, totalStudents) ||
                other.totalStudents == totalStudents) &&
            (identical(other.totalExams, totalExams) ||
                other.totalExams == totalExams) &&
            (identical(other.averageClassScore, averageClassScore) ||
                other.averageClassScore == averageClassScore) &&
            (identical(other.highestScore, highestScore) ||
                other.highestScore == highestScore) &&
            (identical(other.lowestScore, lowestScore) ||
                other.lowestScore == lowestScore) &&
            (identical(other.studentsPassed, studentsPassed) ||
                other.studentsPassed == studentsPassed) &&
            (identical(other.passPercentage, passPercentage) ||
                other.passPercentage == passPercentage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      classroomId,
      classroomName,
      totalStudents,
      totalExams,
      averageClassScore,
      highestScore,
      lowestScore,
      studentsPassed,
      passPercentage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassroomStatsImplCopyWith<_$ClassroomStatsImpl> get copyWith =>
      __$$ClassroomStatsImplCopyWithImpl<_$ClassroomStatsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassroomStatsImplToJson(
      this,
    );
  }
}

abstract class _ClassroomStats implements ClassroomStats {
  const factory _ClassroomStats(
      {@JsonKey(name: 'classroom_id') required final String classroomId,
      @JsonKey(name: 'classroom_name') required final String classroomName,
      @JsonKey(name: 'total_students') required final int totalStudents,
      @JsonKey(name: 'total_exams') required final int totalExams,
      @JsonKey(name: 'average_class_score')
      required final double averageClassScore,
      @JsonKey(name: 'highest_score') required final double highestScore,
      @JsonKey(name: 'lowest_score') required final double lowestScore,
      @JsonKey(name: 'students_passed') required final int studentsPassed,
      @JsonKey(name: 'pass_percentage')
      required final double passPercentage}) = _$ClassroomStatsImpl;

  factory _ClassroomStats.fromJson(Map<String, dynamic> json) =
      _$ClassroomStatsImpl.fromJson;

  @override
  @JsonKey(name: 'classroom_id')
  String get classroomId;
  @override
  @JsonKey(name: 'classroom_name')
  String get classroomName;
  @override
  @JsonKey(name: 'total_students')
  int get totalStudents;
  @override
  @JsonKey(name: 'total_exams')
  int get totalExams;
  @override
  @JsonKey(name: 'average_class_score')
  double get averageClassScore;
  @override
  @JsonKey(name: 'highest_score')
  double get highestScore;
  @override
  @JsonKey(name: 'lowest_score')
  double get lowestScore;
  @override
  @JsonKey(name: 'students_passed')
  int get studentsPassed;
  @override
  @JsonKey(name: 'pass_percentage')
  double get passPercentage;
  @override
  @JsonKey(ignore: true)
  _$$ClassroomStatsImplCopyWith<_$ClassroomStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
