import 'package:flutte_scanner_empty/data/services/api_service.dart';
import 'package:flutte_scanner_empty/data/models/user_model.dart';

class UserRepository {
  final ApiService apiService;

  UserRepository({required this.apiService});

  Future<UserModel?> login(String username, String password) {
    return apiService.login(username, password);
  }
}
