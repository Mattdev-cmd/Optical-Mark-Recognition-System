import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/classroom_provider.dart';
import '../models/index.dart';
import '../services/index.dart';

class ClassroomDetailScreen extends StatefulWidget {
  final String classroomId;
  final String classroomName;

  const ClassroomDetailScreen({
    Key? key,
    required this.classroomId,
    required this.classroomName,
  }) : super(key: key);

  @override
  State<ClassroomDetailScreen> createState() => _ClassroomDetailScreenState();
}

class _ClassroomDetailScreenState extends State<ClassroomDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ClassroomProvider>();
      provider.loadClassroomDetails(widget.classroomId);
      provider.loadStats(widget.classroomId);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.classroomName),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.people), text: 'Students'),
            Tab(icon: Icon(Icons.bar_chart), text: 'Statistics'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEnrollStudentDialog(context),
        child: const Icon(Icons.person_add),
      ),
      body: Consumer<ClassroomProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline, size: 48, color: Colors.red.shade400),
                  const SizedBox(height: 12),
                  Text('Error: ${provider.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      provider.loadClassroomDetails(widget.classroomId);
                      provider.loadStats(widget.classroomId);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _StudentsTab(
                classroom: provider.selectedClassroom,
                classroomId: widget.classroomId,
              ),
              _StatsTab(stats: provider.stats),
            ],
          );
        },
      ),
    );
  }

  void _showEnrollStudentDialog(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final searchController = TextEditingController();
    bool showAddForm = false;
    bool isSubmitting = false;
    List<Map<String, dynamic>> searchResults = [];
    bool isSearching = false;
    final apiClient = context.read<ClassroomProvider>().apiClient;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Toggle between Add New and Search Existing
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            showAddForm ? 'Add New Student' : 'Enroll Student',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            setModalState(() => showAddForm = !showAddForm);
                          },
                          icon: Icon(
                            showAddForm ? Icons.search : Icons.person_add,
                            size: 18,
                          ),
                          label: Text(showAddForm ? 'Search Existing' : 'Add New'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    if (showAddForm) ...[
                      // ===== ADD NEW STUDENT FORM =====
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Student Name',
                          hintText: 'Enter full name',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        textCapitalization: TextCapitalization.words,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          hintText: 'student@example.com',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: FilledButton.icon(
                          onPressed: isSubmitting
                              ? null
                              : () async {
                                  final name = nameController.text.trim();
                                  final email = emailController.text.trim();

                                  if (name.isEmpty || email.isEmpty) {
                                    ScaffoldMessenger.of(ctx).showSnackBar(
                                      const SnackBar(
                                        content: Text('Please fill in both name and email'),
                                        backgroundColor: Colors.orange,
                                      ),
                                    );
                                    return;
                                  }

                                  setModalState(() => isSubmitting = true);
                                  try {
                                    // Create the student account
                                    final student = await apiClient.createStudent(
                                      name: name,
                                      email: email,
                                    );

                                    // Enroll them in this classroom
                                    final studentId = student['id'];
                                    if (studentId != null) {
                                      await ctx
                                          .read<ClassroomProvider>()
                                          .enrollStudent(
                                            widget.classroomId,
                                            studentId,
                                          );
                                    }

                                    setModalState(() => isSubmitting = false);
                                    if (ctx.mounted) {
                                      Navigator.pop(ctx);
                                      ScaffoldMessenger.of(ctx).showSnackBar(
                                        SnackBar(
                                          content: Text('$name added and enrolled!'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    setModalState(() => isSubmitting = false);
                                    if (ctx.mounted) {
                                      ScaffoldMessenger.of(ctx).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            e.toString().contains('already registered')
                                                ? 'This email is already registered. Use Search Existing instead.'
                                                : 'Error: ${e.toString()}',
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                },
                          icon: isSubmitting
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.person_add),
                          label: Text(isSubmitting ? 'Adding...' : 'Add & Enroll Student'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        color: Colors.blue.shade50,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'A student account will be created with default password "student123"',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ] else ...[
                      // ===== SEARCH EXISTING STUDENTS =====
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search by name or email...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: isSearching
                              ? const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                )
                              : null,
                        ),
                        onChanged: (value) async {
                          if (value.length < 2) {
                            setModalState(() => searchResults = []);
                            return;
                          }
                          setModalState(() => isSearching = true);
                          try {
                            final results = await apiClient.searchUsers(
                              query: value,
                              role: 'student',
                            );
                            setModalState(() {
                              searchResults = results;
                              isSearching = false;
                            });
                          } catch (e) {
                            setModalState(() => isSearching = false);
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: searchResults.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      searchController.text.length < 2
                                          ? 'Type at least 2 characters to search'
                                          : 'No students found',
                                      style: TextStyle(color: Colors.grey.shade600),
                                    ),
                                    if (searchController.text.length >= 2) ...[
                                      const SizedBox(height: 12),
                                      OutlinedButton.icon(
                                        onPressed: () {
                                          setModalState(() => showAddForm = true);
                                        },
                                        icon: const Icon(Icons.person_add),
                                        label: const Text('Add New Student Instead'),
                                      ),
                                    ],
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: searchResults.length,
                                itemBuilder: (context, index) {
                                  final user = searchResults[index];
                                  final provider = ctx.read<ClassroomProvider>();
                                  final alreadyEnrolled = provider
                                          .selectedClassroom?.students
                                          .any((s) => s.id == user['id']) ??
                                      false;

                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: alreadyEnrolled
                                            ? Colors.green.shade100
                                            : Colors.blue.shade100,
                                        child: Text(
                                          (user['name'] as String?)?.isNotEmpty == true
                                              ? user['name'][0].toUpperCase()
                                              : '?',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: alreadyEnrolled
                                                ? Colors.green.shade700
                                                : Colors.blue.shade700,
                                          ),
                                        ),
                                      ),
                                      title: Text(user['name'] ?? ''),
                                      subtitle: Text(user['email'] ?? ''),
                                      trailing: alreadyEnrolled
                                          ? Chip(
                                              label: const Text('Enrolled'),
                                              backgroundColor: Colors.green.shade50,
                                            )
                                          : FilledButton.icon(
                                              onPressed: () async {
                                                final success = await ctx
                                                    .read<ClassroomProvider>()
                                                    .enrollStudent(
                                                      widget.classroomId,
                                                      user['id'],
                                                    );
                                                if (success && ctx.mounted) {
                                                  setModalState(() {});
                                                  ScaffoldMessenger.of(ctx).showSnackBar(
                                                    SnackBar(
                                                      content: Text('${user['name']} enrolled!'),
                                                      backgroundColor: Colors.green,
                                                    ),
                                                  );
                                                }
                                              },
                                              icon: const Icon(Icons.person_add, size: 18),
                                              label: const Text('Enroll'),
                                            ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// ==================== STUDENTS TAB ====================

class _StudentsTab extends StatelessWidget {
  final ClassroomWithStudents? classroom;
  final String classroomId;

  const _StudentsTab({required this.classroom, required this.classroomId});

  @override
  Widget build(BuildContext context) {
    if (classroom == null) {
      return const Center(child: Text('Loading classroom data...'));
    }

    final students = classroom!.students;

    if (students.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.people_outline, size: 64, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              const Text(
                'No students enrolled',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tap the + button to enroll students',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () =>
          context.read<ClassroomProvider>().loadClassroomDetails(classroomId),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: students.length + 1, // +1 for header
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.people, color: Colors.blue.shade700),
                      const SizedBox(width: 12),
                      Text(
                        '${students.length} Students Enrolled',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          final student = students[index - 1];
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: Text(
                  student.name.isNotEmpty ? student.name[0].toUpperCase() : '?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
              title: Text(
                student.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(student.email),
              trailing: PopupMenuButton(
                itemBuilder: (ctx) => [
                  const PopupMenuItem(
                    value: 'remove',
                    child: Row(
                      children: [
                        Icon(Icons.person_remove, color: Colors.red, size: 20),
                        SizedBox(width: 8),
                        Text('Remove'),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'remove') {
                    _confirmRemoveStudent(context, student);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _confirmRemoveStudent(BuildContext context, StudentEnrollment student) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove Student'),
        content: Text('Remove ${student.name} from this classroom?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(ctx);
              context
                  .read<ClassroomProvider>()
                  .removeStudent(classroomId, student.id);
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}

// ==================== STATISTICS TAB ====================

class _StatsTab extends StatelessWidget {
  final ClassroomStats? stats;

  const _StatsTab({required this.stats});

  @override
  Widget build(BuildContext context) {
    if (stats == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.bar_chart, size: 64, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              const Text(
                'No statistics available yet',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              const Text(
                'Statistics will appear after exams are assigned and students take them',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Overview cards
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.people,
                  label: 'Students',
                  value: '${stats!.totalStudents}',
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.quiz,
                  label: 'Exams',
                  value: '${stats!.totalExams}',
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.trending_up,
                  label: 'Average',
                  value: '${stats!.averageClassScore.toStringAsFixed(1)}%',
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.check_circle,
                  label: 'Pass Rate',
                  value: '${stats!.passPercentage.toStringAsFixed(1)}%',
                  color: Colors.teal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Score range card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Score Range',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _ScoreIndicator(
                        label: 'Highest',
                        value: stats!.highestScore,
                        color: Colors.green,
                      ),
                      _ScoreIndicator(
                        label: 'Average',
                        value: stats!.averageClassScore,
                        color: Colors.blue,
                      ),
                      _ScoreIndicator(
                        label: 'Lowest',
                        value: stats!.lowestScore,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Pass/fail card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pass / Fail',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        flex: stats!.studentsPassed.clamp(1, 999),
                        child: Container(
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.green.shade400,
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: (stats!.totalStudents - stats!.studentsPassed)
                            .clamp(1, 999),
                        child: Container(
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${stats!.studentsPassed} Passed',
                        style: TextStyle(color: Colors.green.shade700),
                      ),
                      Text(
                        '${stats!.totalStudents - stats!.studentsPassed} Failed',
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final MaterialColor color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color.shade600),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color.shade700,
              ),
            ),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }
}

class _ScoreIndicator extends StatelessWidget {
  final String label;
  final double value;
  final MaterialColor color;

  const _ScoreIndicator({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 64,
          height: 64,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: value / 100,
                strokeWidth: 6,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation(color.shade400),
              ),
              Text(
                '${value.toStringAsFixed(0)}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color.shade700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}
