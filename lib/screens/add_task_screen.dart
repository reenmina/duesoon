import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Task")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(labelText: "Task Title"),
            ),

            SizedBox(height: 20),

            DropdownButtonFormField(
              items: [
                DropdownMenuItem(value: "Pending", child: Text("Pending")),
                DropdownMenuItem(
                  value: "In Progress",
                  child: Text("In Progress"),
                ),
                DropdownMenuItem(value: "Completed", child: Text("Completed")),
              ],
              onChanged: (value) {},
              decoration: InputDecoration(labelText: "Status"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Save Task"),
            ),
          ],
        ),
      ),
    );
  }
}
