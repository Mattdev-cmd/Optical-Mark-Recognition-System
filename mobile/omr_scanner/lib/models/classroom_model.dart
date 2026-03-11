import 'package:freezed_annotation/freezed_annotation.dart';

part 'classroom_model.freezed.dart';
part 'classroom_model.g.dart';

@freezed
class Classroom with _$Classroom {
  const factory Classroom({
    @JsonKey(name: '_id') required String id,
    required String name,
    String? description,
    String? section,
    String? grade,
    @JsonKey(name: 'academic_year') String? academicYear,
    @JsonKey(name: 'max_students') int? maxStudents,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'student_count') int? studentCount,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Classroom;

  factory Classroom.fromJson(Map<String, dynamic> json) =>
      _$ClassroomFromJson(json);
}

@freezed
class ClassroomWithStudents with _$ClassroomWithStudents {
  const factory ClassroomWithStudents({
    @JsonKey(name: '_id') required String id,
    required String name,
    String? description,
    String? section,
    String? grade,
    @JsonKey(name: 'academic_year') String? academicYear,
    @JsonKey(name: 'max_students') int? maxStudents,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'student_count') required int studentCount,
    required List<StudentEnrollment> students,
    @JsonKey(name: 'total_exams') required int totalExams,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ClassroomWithStudents;

  factory ClassroomWithStudents.fromJson(Map<String, dynamic> json) =>
      _$ClassroomWithStudentsFromJson(json);
}

@freezed
class StudentEnrollment with _$StudentEnrollment {
  const factory StudentEnrollment({
    required String id,
    required String name,
    required String email,
    @JsonKey(name: 'exams_taken') int? examsTaken,
    @JsonKey(name: 'average_score') double? averageScore,
    @JsonKey(name: 'roll_number') String? rollNumber,
  }) = _StudentEnrollment;

  factory StudentEnrollment.fromJson(Map<String, dynamic> json) =>
      _$StudentEnrollmentFromJson(json);
}

@freezed
class ClassroomStats with _$ClassroomStats {
  const factory ClassroomStats({
    @JsonKey(name: 'classroom_id') required String classroomId,
    @JsonKey(name: 'classroom_name') required String classroomName,
    @JsonKey(name: 'total_students') required int totalStudents,
    @JsonKey(name: 'total_exams') required int totalExams,
    @JsonKey(name: 'average_class_score') required double averageClassScore,
    @JsonKey(name: 'highest_score') required double highestScore,
    @JsonKey(name: 'lowest_score') required double lowestScore,
    @JsonKey(name: 'students_passed') required int studentsPassed,
    @JsonKey(name: 'pass_percentage') required double passPercentage,
  }) = _ClassroomStats;

  factory ClassroomStats.fromJson(Map<String, dynamic> json) =>
      _$ClassroomStatsFromJson(json);
}
