import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import '../models/index.dart';
import '../services/api_client.dart';

class ScanProvider extends ChangeNotifier {
  final ApiClient apiClient;

  ScanProvider(this.apiClient);

  File? _selectedImage;
  bool _isProcessing = false;
  String? _error;
  ScanResult? _lastResult;

  File? get selectedImage => _selectedImage;
  bool get isProcessing => _isProcessing;
  String? get error => _error;
  ScanResult? get lastResult => _lastResult;
  bool get hasImage => _selectedImage != null;

  void setImage(File image) {
    _selectedImage = image;
    _error = null;
    _lastResult = null;
    notifyListeners();
  }

  void clearImage() {
    _selectedImage = null;
    _error = null;
    notifyListeners();
  }

  Future<bool> processAnswerSheet({
    required String examId,
    required String studentName,
  }) async {
    if (_selectedImage == null) {
      _error = 'No image selected';
      notifyListeners();
      return false;
    }

    _isProcessing = true;
    _error = null;
    notifyListeners();

    try {
      final result = await apiClient.processAnswerSheet(
        examId: examId,
        studentName: studentName,
        image: _selectedImage!,
      );

      _lastResult = result;
      _error = null;
      _isProcessing = false;
      notifyListeners();
      return true;
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        final data = e.response!.data;
        if (data is Map && data.containsKey('detail')) {
          _error = data['detail'].toString();
        } else {
          _error = e.toString();
        }
      } else {
        _error = e.toString();
      }
      _lastResult = null;
      _isProcessing = false;
      notifyListeners();
      return false;
    }
  }

  void clearResult() {
    _lastResult = null;
    _error = null;
    notifyListeners();
  }
}
