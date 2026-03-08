import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/index.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  String? _selectedExamId;

  @override
  void initState() {
    super.initState();
    _loadExams();
  }

  void _loadExams() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExamProvider>().loadExams();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Results'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Results',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Consumer<ScanProvider>(
                builder: (context, scanProvider, _) {
                  if (scanProvider.lastResult != null) {
                    final result = scanProvider.lastResult!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Latest Scan Result',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Student:'),
                                    Text(
                                      result.studentName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Score:'),
                                    Text(
                                      '${result.correctAnswers}/${result.totalQuestions}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Percentage:'),
                                    Text(
                                      '${((result.correctAnswers / result.totalQuestions) * 100).toStringAsFixed(1)}%',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const Text(
                'All Results',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Consumer<ExamProvider>(
                builder: (context, examProvider, _) {
                  return DropdownButtonFormField(
                    value: _selectedExamId,
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('All Exams'),
                      ),
                      ...examProvider.exams
                          .map((exam) => DropdownMenuItem(
                                value: exam.id,
                                child: Text(exam.name),
                              ))
                          .toList(),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedExamId = value;
                      });
                      if (value != null) {
                        context.read<ResultsProvider>().loadResults(value);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Filter by Exam',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              Consumer<ResultsProvider>(
                builder: (context, resultsProvider, _) {
                  if (resultsProvider.isLoading) {
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (resultsProvider.results.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.inbox,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No results found',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: resultsProvider.results.length,
                    itemBuilder: (context, index) {
                      final result = resultsProvider.results[index] as Map<String, dynamic>;
                      final correctAnswers = (result['correct_answers'] as num?)?.toInt() ?? 0;
                      final totalQuestions = (result['total_questions'] as num?)?.toInt() ?? 0;
                      final percentage = totalQuestions > 0
                          ? ((correctAnswers / totalQuestions) * 100).toStringAsFixed(1)
                          : '0';

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text(result['student_name'] as String? ?? 'Unknown'),
                          subtitle: Text(
                            'Score: $correctAnswers/$totalQuestions ($percentage%)',
                          ),
                          trailing: const Icon(Icons.arrow_forward),
                          onTap: () {
                            _showResultDetails(context, result);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showResultDetails(BuildContext context, dynamic result) {
    final resultMap = result as Map<String, dynamic>;
    final correctAnswers = (resultMap['correct_answers'] as num?)?.toInt() ?? 0;
    final totalQuestions = (resultMap['total_questions'] as num?)?.toInt() ?? 0;
    final studentAnswers = resultMap['student_answers'] as List<dynamic>? ?? [];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(resultMap['student_name'] as String? ?? 'Unknown'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                title: const Text('Score'),
                trailing: Text(
                  '$correctAnswers/$totalQuestions',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: const Text('Percentage'),
                trailing: Text(
                  '${totalQuestions > 0 ? ((correctAnswers / totalQuestions) * 100).toStringAsFixed(1) : '0'}%',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Questions Answered:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              if (studentAnswers.isNotEmpty)
                ...studentAnswers.asMap().entries.map((entry) {
                  final idx = entry.key + 1;
                  final answer = entry.value as Map<String, dynamic>?;
                  final isCorrect = answer?['is_correct'] as bool? ?? false;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      'Q$idx: ${answer?['student_answer'] ?? 'No Answer'}',
                      style: TextStyle(
                        color: isCorrect ? Colors.green : Colors.red,
                      ),
                    ),
                  );
                })
              else
                const Text('No detailed answers available'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
