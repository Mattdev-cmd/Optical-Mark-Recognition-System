import 'package:flutter/foundation.dart';
import '../services/api_client.dart';

class ResultsProvider extends ChangeNotifier {
  final ApiClient apiClient;

  ResultsProvider(this.apiClient);

  List<dynamic> _results = [];
  bool _isLoading = false;
  String? _error;

  List<dynamic> get results => _results;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadResults(String examId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final results = await apiClient.getExamResults(examId);
      _results = results.cast<dynamic>();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _results = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearResults() {
    _results = [];
    _error = null;
    notifyListeners();
  }
}
