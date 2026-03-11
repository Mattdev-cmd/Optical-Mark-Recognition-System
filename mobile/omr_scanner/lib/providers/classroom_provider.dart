import 'package:flutter/material.dart';
import '../models/index.dart';
import '../services/index.dart';

class ClassroomProvider extends ChangeNotifier {
  final ApiClient _apiClient;

  List<Classroom> classrooms = [];
  ClassroomWithStudents? selectedClassroom;
  ClassroomStats? stats;
  bool isLoading = false;
  String? error;

  ClassroomProvider(this._apiClient);

  ApiClient get apiClient => _apiClient;

  Future<void> loadClassrooms() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      classrooms = await _apiClient.getClassrooms();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadClassroomDetails(String classroomId) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      selectedClassroom = await _apiClient.getClassroomDetails(classroomId);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadStats(String classroomId) async {
    try {
      stats = await _apiClient.getClassroomStats(classroomId);
      notifyListeners();
    } catch (e) {
      // Stats may not be available if no exams assigned yet
      stats = null;
    }
  }

  Future<Classroom?> createClassroom({
    required String name,
    String? description,
    String? section,
    String? grade,
    String? academicYear,
  }) async {
    try {
      final newClassroom = await _apiClient.createClassroom(
        name: name,
        description: description,
        section: section,
        grade: grade,
        academicYear: academicYear,
      );
      classrooms.add(newClassroom);
      notifyListeners();
      return newClassroom;
    } catch (e) {
      error = e.toString();
      notifyListeners();
      return null;
    }
  }

  Future<bool> deleteClassroom(String classroomId) async {
    try {
      await _apiClient.deleteClassroom(classroomId);
      classrooms.removeWhere((c) => c.id == classroomId);
      notifyListeners();
      return true;
    } catch (e) {
      error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> enrollStudent(String classroomId, String studentId) async {
    try {
      await _apiClient.enrollStudent(classroomId, studentId);
      await loadClassroomDetails(classroomId);
      return true;
    } catch (e) {
      error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> removeStudent(String classroomId, String studentId) async {
    try {
      await _apiClient.removeStudent(classroomId, studentId);
      await loadClassroomDetails(classroomId);
      return true;
    } catch (e) {
      error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
