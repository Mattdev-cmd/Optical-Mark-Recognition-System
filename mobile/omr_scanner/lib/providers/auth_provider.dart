import 'package:flutter/material.dart';
import '../models/index.dart';
import '../services/index.dart';

class AuthProvider extends ChangeNotifier {
  final ApiClient _apiClient;
  
  User? currentUser;
  bool isLoading = false;
  String? error;
  bool isLoggedIn = false;
  
  AuthProvider(this._apiClient);
  
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    String role = 'teacher',
  }) async {
    isLoading = true;
    error = null;
    notifyListeners();
    
    try {
      final response = await _apiClient.register(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        role: role,
      );
      currentUser = response.user;
      isLoggedIn = true;
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    error = null;
    notifyListeners();
    
    try {
      final response = await _apiClient.login(
        email: email,
        password: password,
      );
      currentUser = response.user;
      isLoggedIn = true;
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  void logout() {
    _apiClient.logout();
    currentUser = null;
    isLoggedIn = false;
    notifyListeners();
  }
}
