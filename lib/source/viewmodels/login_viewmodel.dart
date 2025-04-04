

import 'package:flutte_scanner_empty/source/data/repository/user_repository.dart';
import 'package:flutte_scanner_empty/source/models/user_model.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  UserModel? user;
  String? errorMessage;

  LoginViewModel({required this.userRepository});

  Future<void> login(String username, String password) async {
    try {
      user = await userRepository.login(username, password);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
