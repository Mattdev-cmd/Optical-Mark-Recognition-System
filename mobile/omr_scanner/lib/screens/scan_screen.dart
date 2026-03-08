import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../providers/index.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late TextEditingController _studentNameController;
  String? _selectedExamId;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _studentNameController = TextEditingController();
    _loadExams();
  }

  void _loadExams() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExamProvider>().loadExams();
    });
  }

  @override
  void dispose() {
    _studentNameController.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? photo = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (photo != null && mounted) {
      context.read<ScanProvider>().setImage(File(photo.path));
    }
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image != null && mounted) {
      context.read<ScanProvider>().setImage(File(image.path));
    }
  }

  Future<void> _processSheet() async {
    if (_selectedExamId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an exam')),
      );
      return;
    }

    if (_studentNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter student name')),
      );
      return;
    }

    final scanProvider = context.read<ScanProvider>();

    if (scanProvider.selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    final success = await scanProvider.processAnswerSheet(
      examId: _selectedExamId!,
      studentName: _studentNameController.text,
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sheet processed successfully!')),
      );
      // Navigate to results or show result
      if (scanProvider.lastResult != null) {
        Navigator.of(context).pushNamed('/results');
      }
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Processing failed: ${scanProvider.error}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Answer Sheet'),
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
                'Scan Answer Sheet',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _studentNameController,
                decoration: InputDecoration(
                  hintText: 'Student Name',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Consumer<ExamProvider>(
                builder: (context, examProvider, _) {
                  if (examProvider.isLoading) {
                    return const CircularProgressIndicator();
                  }

                  return DropdownButtonFormField(
                    value: _selectedExamId,
                    items: examProvider.exams
                        .map((exam) => DropdownMenuItem(
                              value: exam.id,
                              child: Text(exam.name),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedExamId = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Select Exam',
                      prefixIcon: const Icon(Icons.library_books),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              Consumer<ScanProvider>(
                builder: (context, scanProvider, _) {
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade50,
                    ),
                    child: scanProvider.hasImage
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              scanProvider.selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image,
                                size: 64,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Take or upload photo',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                  );
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _pickImageFromCamera,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Take Photo'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _pickImageFromGallery,
                icon: const Icon(Icons.photo_library),
                label: const Text('Upload Photo'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(height: 24),
              Consumer<ScanProvider>(
                builder: (context, scanProvider, _) {
                  return ElevatedButton(
                    onPressed: scanProvider.isProcessing ? null : _processSheet,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: scanProvider.isProcessing
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Process Sheet'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

