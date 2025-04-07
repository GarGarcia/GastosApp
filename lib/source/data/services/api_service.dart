import 'dart:convert';
import 'package:flutte_scanner_empty/source/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<UserModel?> login(String username, String password) async {
    final response = await http.get(
      Uri.parse('$baseUrl/login'),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
        return null;
    }
  }
}
