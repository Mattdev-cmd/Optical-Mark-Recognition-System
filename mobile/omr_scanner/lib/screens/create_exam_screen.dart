import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/index.dart';
import '../providers/index.dart';

class CreateExamScreen extends StatefulWidget {
  const CreateExamScreen({Key? key}) : super(key: key);

  @override
  State<CreateExamScreen> createState() => _CreateExamScreenState();
}

class _CreateExamScreenState extends State<CreateExamScreen> {
  late TextEditingController _nameController;
  late TextEditingController _subjectController;
  late TextEditingController _questionsController;
  
  final List<TextEditingController> _answerControllers = [];
  int _totalQuestions = 20;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _subjectController = TextEditingController();
    _questionsController = TextEditingController(text: '20');
    _initializeAnswerControllers();
  }

  void _initializeAnswerControllers() {
    _answerControllers.clear();
    for (int i = 0; i < _totalQuestions; i++) {
      _answerControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _subjectController.dispose();
    _questionsController.dispose();
    for (var controller in _answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _handleCreateExam() async {
    if (_nameController.text.isEmpty ||
        _subjectController.text.isEmpty ||
        _answersEmpty()) {
      setState(() {
        _error = 'Please fill in all fields';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final answerKey = <AnswerKey>[];
      for (int i = 0; i < _totalQuestions; i++) {
        if (_answerControllers[i].text.isNotEmpty) {
          answerKey.add(AnswerKey(
            questionNumber: i + 1,
            correctAnswer: _answerControllers[i].text.toUpperCase(),
          ));
        }
      }

      final examProvider = context.read<ExamProvider>();
      await examProvider.createExam(
        name: _nameController.text,
        subject: _subjectController.text,
        totalQuestions: _totalQuestions,
        choices: ['A', 'B', 'C', 'D'],
        answerKey: answerKey,
      );

      if (mounted) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Exam created successfully')),
        );
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _answersEmpty() {
    return _answerControllers.every((c) => c.text.isEmpty);
  }

  void _updateQuestionCount() {
    final count = int.tryParse(_questionsController.text) ?? 20;
    if (count != _totalQuestions && count > 0 && count <= 200) {
      setState(() {
        _totalQuestions = count;
        _initializeAnswerControllers();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Exam'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Exam Name',
                  prefixIcon: const Icon(Icons.school),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _subjectController,
                decoration: InputDecoration(
                  hintText: 'Subject',
                  prefixIcon: const Icon(Icons.subject),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _questionsController,
                      decoration: InputDecoration(
                        hintText: 'Total Questions',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (_) => _updateQuestionCount(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Answer Key (A-D)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: _totalQuestions,
                itemBuilder: (context, index) {
                  return TextField(
                    controller: _answerControllers[index],
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: InputDecoration(
                      hintText: '${index + 1}',
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    textCapitalization: TextCapitalization.characters,
                  );
                },
              ),
              if (_error != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _error!,
                    style: TextStyle(color: Colors.red.shade700),
                  ),
                )
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleCreateExam,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Create Exam'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
