import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/index.dart';

class ApiClient {
  static const String baseUrl = "http://10.0.2.2:8000";
  late Dio _dio;
  late SharedPreferences _prefs;
  String? _token;

  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_token != null) {
            options.headers['Authorization'] = 'Bearer $_token';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs.getString('auth_token');
  }

  // Auth endpoints
  Future<AuthResponse> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    String role = 'teacher',
  }) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'confirm_password': confirmPassword,
          'role': role,
        },
      );
      return AuthResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      final authResponse = AuthResponse.fromJson(response.data);
      _token = authResponse.accessToken;
      await _prefs.setString('auth_token', _token!);
      return authResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getCurrentUser() async {
    try {
      final response = await _dio.get('/auth/me');
      return User.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Exam endpoints
  Future<List<Exam>> getExams() async {
    try {
      final response = await _dio.get('/exams');
      return (response.data as List)
          .map((item) => Exam.fromJson(item))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Exam> getExam(String examId) async {
    try {
      final response = await _dio.get('/exams/$examId');
      return Exam.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Exam> createExam({
    required String name,
    required String subject,
    required int totalQuestions,
    required List<String> choices,
    required List<AnswerKey> answerKey,
  }) async {
    try {
      final response = await _dio.post(
        '/exams/create',
        data: {
          'name': name,
          'subject': subject,
          'total_questions': totalQuestions,
          'choices': choices,
          'answer_key': answerKey.map((e) => e.toJson()).toList(),
        },
      );
      return Exam.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Scanning endpoints
  Future<ScanResult> processAnswerSheet({
    required String examId,
    required String studentName,
    required dynamic image, // Can be File or List<int>
  }) async {
    try {
      late MultipartFile imageFile;
      
      if (image is String) {
        // File path
        imageFile = await MultipartFile.fromFile(image, filename: 'sheet.jpg');
      } else if (image is List<int>) {
        // Bytes
        imageFile = MultipartFile.fromBytes(image, filename: 'sheet.jpg');
      } else if (image.runtimeType.toString().contains('XFile')) {
        // XFile from image_picker
        final bytes = await image.readAsBytes();
        imageFile = MultipartFile.fromBytes(bytes, filename: 'sheet.jpg');
      } else {
        // Assume it's a File
        final bytes = await image.readAsBytes();
        imageFile = MultipartFile.fromBytes(bytes, filename: 'sheet.jpg');
      }

      final formData = FormData.fromMap({
        'exam_id': examId,
        'student_name': studentName,
        'sheet_image': imageFile,
      });

      final response = await _dio.post(
        '/scan/process-sheet',
        data: formData,
      );

      return ScanResult.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ResultSummary>> getExamResults(String examId) async {
    try {
      final response = await _dio.get('/scan/results/$examId');
      return (response.data as List)
          .map((item) => ResultSummary.fromJson(item))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<ScanResult> getResultDetails(String resultId) async {
    try {
      final response = await _dio.get('/scan/result/$resultId');
      return ScanResult.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  void logout() {
    _token = null;
    _prefs.remove('auth_token');
  }
}
