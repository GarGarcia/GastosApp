import 'package:flutte_scanner_empty/data/repository/user_repository.dart';
import 'package:flutte_scanner_empty/data/models/user_model.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  String username = '';
  String password = '';
  UserModel? user;
  String? errorMessage = '';
  bool isLoading = false;

  LoginViewModel({required this.userRepository});

  Future<void> login() async {
    isLoading = true;
    notifyListeners();

    try {
      user = await userRepository.login(username, password);
      errorMessage = '';
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  data() {
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
