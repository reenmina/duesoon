import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'task_list_screen.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  final String userId;

  const HomeScreen({super.key, required this.userId});

  void logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
      (route) => false, // removes all previous pages
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "DueSoon",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF3EB489),

        // LOGOUT BUTTON
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Card(
              child: ListTile(
                leading: Icon(Icons.task_alt, color: Color(0xFF3EB489)),
                title: Text("Manage Your Tasks"),
                subtitle: Text("Keep track of deadlines easily"),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TaskListScreen(userId: userId),
                  ),
                );
              },
              icon: const Icon(Icons.list),
              label: const Text("View Tasks"),
            ),

            const SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddTaskScreen(userId: userId),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}
