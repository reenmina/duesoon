import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  final String userId;

  const TaskListScreen({super.key, required this.userId});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  // LOAD TASKS
  Future<void> loadTasks() async {
    setState(() => isLoading = true);

    try {
      final data = await ApiService.getTasks(widget.userId);
      tasks = data;
    } catch (e) {
      tasks = [];
    }

    if (!mounted) return;
    setState(() => isLoading = false);
  }

  // DELETE TASK
  Future<void> deleteTask(String id) async {
    await ApiService.deleteTask(id);
    if (!mounted) return;
    loadTasks();
  }

  // CONFIRM DELETE
  void confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Task"),
        content: const Text("Are you sure you want to delete this task?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              deleteTask(id);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // OPEN ADD TASK
  Future<void> goToAddTask() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddTaskScreen(userId: widget.userId)),
    );

    if (!mounted) return;
    if (result == true) loadTasks();
  }

  // EDIT TASK
  Future<void> editTask(Map task) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditTaskScreen(
          id: task["id"].toString(),
          title: task["title"] ?? "",
          status: task["status"] ?? "Pending",
          deadline: task["deadline"] ?? "",
        ),
      ),
    );

    if (!mounted) return;
    if (result == true) loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tasks"),
        backgroundColor: const Color(0xFF3EB489),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3EB489),
        onPressed: goToAddTask,
        child: const Icon(Icons.add),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadTasks,
              child: tasks.isEmpty
                  ? ListView(
                      children: const [
                        SizedBox(height: 200),
                        Center(
                          child: Text(
                            "No tasks found",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          child: ListTile(
                            onTap: () => editTask(task),
                            title: Text(task["title"] ?? ""),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Status: ${task["status"] ?? ""}"),
                                Text("Deadline: ${task["deadline"] ?? ""}"),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                confirmDelete(task["id"].toString());
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}
