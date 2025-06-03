import 'package:flutte_scanner_empty/data/repository/user_repository.dart';
import 'package:flutte_scanner_empty/data/models/user_model.dart';
import 'package:flutte_scanner_empty/data/services/supabase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final SupabaseAuthService authService;

  String username = '';
  String password = '';
  UserModel? user;
  String errorMessage = "";
  bool isLoading = false;

  LoginViewModel(this.authService, {required this.userRepository});

  Future<void> login() async {
    isLoading = true;
    notifyListeners();

    try {
      final AuthResponse response = await authService.signInWithEmailPassword(
        username,
        password,
      );
      if (response.user == null) {
        errorMessage = "Usuario o contraseña incorrectos";
      }else{
        errorMessage = '';
      }
    } on AuthException catch (e) {
      errorMessage = "Error: $e";
    } catch (e) {
      errorMessage = "Error: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }

    // try {
    //   user = await userRepository.login(username, password);
    //   errorMessage = '';
    // } catch (e) {
    //   errorMessage = e.toString();
    // } finally {
    //   isLoading = false;
    //   notifyListeners();
    // }
  }
}
