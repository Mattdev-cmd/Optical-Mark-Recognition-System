import 'package:flutter/material.dart';
import '../models/index.dart';
import '../services/index.dart';

class ExamProvider extends ChangeNotifier {
  final ApiClient _apiClient;
  
  List<Exam> exams = [];
  bool isLoading = false;
  String? error;
  
  ExamProvider(this._apiClient);
  
  Future<void> loadExams() async {
    isLoading = true;
    error = null;
    notifyListeners();
    
    try {
      print('[ExamProvider] Loading exams...');
      exams = await _apiClient.getExams();
      print('[ExamProvider] Loaded ${exams.length} exams');
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print('[ExamProvider] Error loading exams: $e');
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }
  
  Future<Exam?> createExam({
    required String name,
    required String subject,
    required int totalQuestions,
    required List<String> choices,
    required List<AnswerKey> answerKey,
  }) async {
    try {
      final newExam = await _apiClient.createExam(
        name: name,
        subject: subject,
        totalQuestions: totalQuestions,
        choices: choices,
        answerKey: answerKey,
      );
      exams.add(newExam);
      notifyListeners();
      return newExam;
    } catch (e) {
      error = e.toString();
      notifyListeners();
      return null;
    }
  }
  
  Future<void> deleteExam(String examId) async {
    try {
      // TODO: Implement delete in API client
      exams.removeWhere((exam) => exam.id == examId);
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }
}
