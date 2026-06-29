import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2/duesoon_api";

  // REGISTER
  static Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/register.php"),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {"name": name, "email": email, "password": password},
    );

    try {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      return {"status": "error", "message": "Invalid response"};
    }
  }

  // LOGIN
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login.php"),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {"email": email, "password": password},
    );

    try {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      return {"status": "error", "message": "Invalid response"};
    }
  }

  // GET TASKS
  static Future<List> getTasks(String userId) async {
    final response = await http.post(
      Uri.parse("$baseUrl/get_tasks.php"),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {"user_id": userId},
    );

    try {
      return jsonDecode(response.body) as List;
    } catch (e) {
      return [];
    }
  }

  // ADD TASK
  static Future<Map<String, dynamic>> addTask(
    String userId,
    String title,
    String status,
    String deadline,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/add_task.php"),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        "user_id": userId,
        "title": title,
        "status": status,
        "deadline": deadline,
      },
    );

    try {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      return {"status": "error", "message": "Invalid response"};
    }
  }

  // DELETE TASK
  static Future<Map<String, dynamic>> deleteTask(String id) async {
    final response = await http.post(
      Uri.parse("$baseUrl/delete_task.php"),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {"id": id},
    );

    try {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      return {"status": "error", "message": "Invalid response"};
    }
  }

  // UPDATE TASK
  static Future<Map<String, dynamic>> updateTask(
    String id,
    String title,
    String status,
    String deadline,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/update_task.php"),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {"id": id, "title": title, "status": status, "deadline": deadline},
    );

    try {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      return {"status": "error", "message": "Invalid response"};
    }
  }
}
