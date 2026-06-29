import 'package:flutter/material.dart';
import '../services/api_service.dart';

class EditTaskScreen extends StatefulWidget {
  final String id;
  final String title;
  final String status;
  final String deadline;

  const EditTaskScreen({
    super.key,
    required this.id,
    required this.title,
    required this.status,
    required this.deadline,
  });

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController titleController;
  late TextEditingController deadlineController;
  late String status;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    deadlineController = TextEditingController(text: widget.deadline);
    status = widget.status;
  }

  // DATE PICKER
  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (picked != null && mounted) {
      setState(() {
        deadlineController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  // UPDATE TASK
  Future<void> updateTask() async {
    if (titleController.text.trim().isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Title cannot be empty")));
      return;
    }

    if (!mounted) return;
    setState(() => isLoading = true);

    try {
      final response = await ApiService.updateTask(
        widget.id,
        titleController.text.trim(),
        status,
        deadlineController.text.trim(),
      );

      if (!mounted) return;
      setState(() => isLoading = false);

      if (response["status"] == "success") {
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response["message"] ?? "Update failed")),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Server error. Try again")));
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Task"),
        backgroundColor: const Color(0xFF3EB489),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // TITLE
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // STATUS
            DropdownButtonFormField<String>(
              initialValue: status,
              items: [
                "Pending",
                "In Progress",
                "Completed",
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (value) {
                if (value != null && mounted) setState(() => status = value);
              },
              decoration: const InputDecoration(
                labelText: "Status",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // DEADLINE
            TextField(
              controller: deadlineController,
              readOnly: true,
              onTap: pickDate,
              decoration: const InputDecoration(
                labelText: "Deadline (Tap to pick date)",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 20),

            // UPDATE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3EB489),
                  padding: const EdgeInsets.all(14),
                ),
                onPressed: isLoading ? null : updateTask,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Update Task"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
