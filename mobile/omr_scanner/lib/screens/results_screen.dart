import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/index.dart';
import '../models/index.dart';

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
                    initialValue: _selectedExamId,
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
                      final resultSummary = resultsProvider.results[index] as ResultSummary;
                      final percentage = resultSummary.totalQuestions > 0
                          ? ((resultSummary.correctAnswers / resultSummary.totalQuestions) * 100).toStringAsFixed(1)
                          : '0';

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text(resultSummary.studentName),
                          subtitle: Text(
                            'Score: ${resultSummary.correctAnswers}/${resultSummary.totalQuestions} ($percentage%)',
                          ),
                          trailing: const Icon(Icons.arrow_forward),
                          onTap: () {
                            _showResultDetails(context, resultSummary.resultId);
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

  void _showResultDetails(BuildContext context, String resultId) {
    showDialog(
      context: context,
      builder: (context) => FutureBuilder<ScanResult>(
        future: context.read<ScanProvider>().apiClient.getResultDetails(resultId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AlertDialog(
              title: Text('Loading...'),
              content: SizedBox(
                height: 50,
                child: Center(child: CircularProgressIndicator()),
              ),
            );
          }

          if (snapshot.hasError) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('Failed to load result: ${snapshot.error}'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            );
          }

          if (!snapshot.hasData) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('No result data found'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            );
          }

          final result = snapshot.data!;
          final correctAnswers = result.correctAnswers;
          final totalQuestions = result.totalQuestions;
          final studentAnswers = result.studentAnswers;
          final percentage = result.scorePercentage.toStringAsFixed(1);

          return AlertDialog(
            title: Text(result.studentName),
            content: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      title: const Text('Score'),
                      trailing: Text(
                        '$correctAnswers/$totalQuestions',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: const Text('Percentage'),
                      trailing: Text(
                        '${totalQuestions > 0 ? ((correctAnswers / totalQuestions) * 100).toStringAsFixed(1) : '0'}%',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Detailed Answer Breakdown:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    if (studentAnswers.isNotEmpty)
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: studentAnswers.asMap().entries.map((entry) {
                            final idx = entry.key;
                            final answer = entry.value;
                            final isCorrect = answer.isCorrect;

                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'Q${answer.questionNumber}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Detected:',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(top: 4),
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: isCorrect
                                                    ? Colors.green.shade50
                                                    : Colors.red.shade50,
                                                border: Border.all(
                                                  color: isCorrect
                                                      ? Colors.green
                                                      : Colors.red,
                                                ),
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                answer.studentAnswer ?? '-',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: isCorrect
                                                      ? Colors.green.shade700
                                                      : Colors.red.shade700,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Correct:',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(top: 4),
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.blue.shade50,
                                                border: Border.all(
                                                  color: Colors.blue,
                                                ),
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                answer.correctAnswer,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue.shade700,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: isCorrect
                                              ? Colors.green.shade100
                                              : Colors.red.shade100,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          isCorrect ? Icons.check : Icons.close,
                                          color: isCorrect ? Colors.green : Colors.red,
                                          size: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (idx < studentAnswers.length - 1)
                                  Divider(
                                    height: 1,
                                    color: Colors.grey.shade300,
                                  ),
                              ],
                            );
                          }).toList(),
                        ),
                      )
                    else
                      const Text('No detailed answers available'),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          );
        },
      ),
    );
  }
}
