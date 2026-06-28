import 'package:flutter/material.dart';

class TaskListScreen extends StatelessWidget {
  final tasks = [
    {"title": "Math Assignment", "status": "Pending"},
    {"title": "AI Project", "status": "In Progress"},
    {"title": "Database Report", "status": "Completed"},
  ];

  Color getColor(String status) {
    if (status == "Completed") return Colors.green;
    if (status == "In Progress") return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Tasks")),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Icon(Icons.task, color: Color(0xFF3EB489)),
              title: Text(tasks[index]["title"]!),
              subtitle: Text(tasks[index]["status"]!),
              trailing: Icon(
                Icons.circle,
                color: getColor(tasks[index]["status"]!),
              ),
            ),
          );
        },
      ),
    );
  }
}
