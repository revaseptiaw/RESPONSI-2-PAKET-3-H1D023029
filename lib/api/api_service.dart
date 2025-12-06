import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Untuk Flutter Web / Chrome
  static const String baseUrl = "http://localhost:3000";

  // =========================
  // REGISTER
  // =========================
  static Future<bool> register(String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/register"),
        body: jsonEncode({"email": email, "password": password}),
        headers: {"Content-Type": "application/json"},
      );

      final data = jsonDecode(res.body);
      return data["success"] == true;
    } catch (e) {
      print("Error register: $e");
      return false;
    }
  }

  // =========================
  // LOGIN
  // =========================
  static Future<bool> login(String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/login"),
        body: jsonEncode({"email": email, "password": password}),
        headers: {"Content-Type": "application/json"},
      );

      final data = jsonDecode(res.body);
      return data["success"] == true;
    } catch (e) {
      print("Error login: $e");
      return false;
    }
  }

  // =========================
  // GET ALL BOOKS
  // =========================
  static Future<List<dynamic>> getBooks() async {
    final res = await http.get(Uri.parse("$baseUrl/books"));
    return jsonDecode(res.body);
  }

  // =========================
  // ADD BOOK
  // =========================
  static Future<Map<String, dynamic>> addBook(Map<String, dynamic> data) async {
    final res = await http.post(
      Uri.parse("$baseUrl/books"),
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );
    return jsonDecode(res.body);
  }

  // =========================
  // UPDATE BOOK
  // =========================
  static Future<Map<String, dynamic>> updateBook(
    String id,
    Map<String, dynamic> data,
  ) async {
    final res = await http.put(
      Uri.parse("$baseUrl/books/$id"),
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );
    return jsonDecode(res.body);
  }

  // =========================
  // DELETE BOOK
  // =========================
  static Future<Map<String, dynamic>> deleteBook(String id) async {
    final res = await http.delete(Uri.parse("$baseUrl/books/$id"));
    return jsonDecode(res.body);
  }
}
