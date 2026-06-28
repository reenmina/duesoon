import 'package:flutter/material.dart';
import 'task_list_screen.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DueSoon Dashboard")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: Icon(Icons.task_alt, color: Color(0xFF3EB489)),
                title: Text("Manage Your Tasks"),
                subtitle: Text("Keep track of deadlines easily"),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TaskListScreen()),
                );
              },
              icon: Icon(Icons.list),
              label: Text("View Tasks"),
            ),

            SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddTaskScreen()),
                );
              },
              icon: Icon(Icons.add),
              label: Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}
