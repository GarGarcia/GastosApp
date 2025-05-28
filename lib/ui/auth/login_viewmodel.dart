import 'package:flutte_scanner_empty/data/repository/user_repository.dart';
import 'package:flutte_scanner_empty/data/models/user_model.dart';
import 'package:flutte_scanner_empty/data/services/supabase_auth_service.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final SupabaseAuthService authService;

  String username = '';
  String password = '';
  UserModel? user;
  String? errorMessage = '';
  bool isLoading = false;

  LoginViewModel(this.authService, {required this.userRepository});

  Future<String?> login() async {
    isLoading = true;
    notifyListeners();

    try{
      await authService.signInWithEmailPassword(username, password);
      return "";
    } catch (e){
       return 'Usuario o contraseña no validos';
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

  Widget data() {
    if (isLoading == true) {
      return CircularProgressIndicator();
    } else if (errorMessage != '') {
      return Text("$errorMessage, Usuario: $username, Password: $password");
    } else if (user != null) {
      return Text(
        "Token: ${user?.accessToken}, Token type: ${user?.tokenType}, Expires In: ${user?.expiresIn}, Usuario: $username, Password: $password",
      );
    } else {
      return Text("No hay resultados");
    }
  }
}
