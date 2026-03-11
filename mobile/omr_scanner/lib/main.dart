import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/index.dart';
import 'services/index.dart';
import 'providers/index.dart';

late ApiClient _apiClient;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServices();
  runApp(const OMRScannerApp());
}

Future<void> setupServices() async {
  _apiClient = ApiClient();
  await _apiClient.init();
}

class OMRScannerApp extends StatelessWidget {
  const OMRScannerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(_apiClient)),
        ChangeNotifierProvider(create: (_) => ExamProvider(_apiClient)),
        ChangeNotifierProvider(create: (_) => ScanProvider(_apiClient)),
        ChangeNotifierProvider(create: (_) => ResultsProvider(_apiClient)),
        ChangeNotifierProvider(create: (_) => ClassroomProvider(_apiClient)),
      ],
      child: MaterialApp(
        title: 'OMR Scanner',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: const LoginScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/dashboard': (context) => const DashboardScreen(),
          '/scan': (context) => const ScanScreen(),
          '/results': (context) => const ResultsScreen(),
          '/classrooms': (context) => const ClassroomListScreen(),
        },
      ),
    );
  }
}
