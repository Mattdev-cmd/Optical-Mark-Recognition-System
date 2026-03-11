// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classroom_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassroomImpl _$$ClassroomImplFromJson(Map<String, dynamic> json) =>
    _$ClassroomImpl(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      section: json['section'] as String?,
      grade: json['grade'] as String?,
      academicYear: json['academic_year'] as String?,
      maxStudents: (json['max_students'] as num?)?.toInt(),
      createdBy: json['created_by'] as String?,
      studentCount: (json['student_count'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ClassroomImplToJson(_$ClassroomImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'section': instance.section,
      'grade': instance.grade,
      'academic_year': instance.academicYear,
      'max_students': instance.maxStudents,
      'created_by': instance.createdBy,
      'student_count': instance.studentCount,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$ClassroomWithStudentsImpl _$$ClassroomWithStudentsImplFromJson(
        Map<String, dynamic> json) =>
    _$ClassroomWithStudentsImpl(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      section: json['section'] as String?,
      grade: json['grade'] as String?,
      academicYear: json['academic_year'] as String?,
      maxStudents: (json['max_students'] as num?)?.toInt(),
      createdBy: json['created_by'] as String?,
      studentCount: (json['student_count'] as num).toInt(),
      students: (json['students'] as List<dynamic>)
          .map((e) => StudentEnrollment.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalExams: (json['total_exams'] as num).toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ClassroomWithStudentsImplToJson(
        _$ClassroomWithStudentsImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'section': instance.section,
      'grade': instance.grade,
      'academic_year': instance.academicYear,
      'max_students': instance.maxStudents,
      'created_by': instance.createdBy,
      'student_count': instance.studentCount,
      'students': instance.students,
      'total_exams': instance.totalExams,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$StudentEnrollmentImpl _$$StudentEnrollmentImplFromJson(
        Map<String, dynamic> json) =>
    _$StudentEnrollmentImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      examsTaken: (json['exams_taken'] as num?)?.toInt(),
      averageScore: (json['average_score'] as num?)?.toDouble(),
      rollNumber: json['roll_number'] as String?,
    );

Map<String, dynamic> _$$StudentEnrollmentImplToJson(
        _$StudentEnrollmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'exams_taken': instance.examsTaken,
      'average_score': instance.averageScore,
      'roll_number': instance.rollNumber,
    };

_$ClassroomStatsImpl _$$ClassroomStatsImplFromJson(Map<String, dynamic> json) =>
    _$ClassroomStatsImpl(
      classroomId: json['classroom_id'] as String,
      classroomName: json['classroom_name'] as String,
      totalStudents: (json['total_students'] as num).toInt(),
      totalExams: (json['total_exams'] as num).toInt(),
      averageClassScore: (json['average_class_score'] as num).toDouble(),
      highestScore: (json['highest_score'] as num).toDouble(),
      lowestScore: (json['lowest_score'] as num).toDouble(),
      studentsPassed: (json['students_passed'] as num).toInt(),
      passPercentage: (json['pass_percentage'] as num).toDouble(),
    );

Map<String, dynamic> _$$ClassroomStatsImplToJson(
        _$ClassroomStatsImpl instance) =>
    <String, dynamic>{
      'classroom_id': instance.classroomId,
      'classroom_name': instance.classroomName,
      'total_students': instance.totalStudents,
      'total_exams': instance.totalExams,
      'average_class_score': instance.averageClassScore,
      'highest_score': instance.highestScore,
      'lowest_score': instance.lowestScore,
      'students_passed': instance.studentsPassed,
      'pass_percentage': instance.passPercentage,
    };
