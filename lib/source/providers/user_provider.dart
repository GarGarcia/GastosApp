import 'package:flutte_scanner_empty/source/data/repository/user_repository.dart';
import 'package:flutte_scanner_empty/source/data/services/api_service.dart';
import 'package:flutte_scanner_empty/source/viewmodels/login_viewmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class UserProvider extends StatelessWidget {
  final Widget child;

  UserProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (_) => LoginViewModel(
            userRepository: UserRepository(
              apiService: ApiService(baseUrl: 'https://api.example.com'),
            ),
          ),
      child: child,
    );
  }
}
