import 'package:flutte_scanner_empty/core/configurations.dart';
import 'package:flutte_scanner_empty/data/repository/user_repository.dart';
import 'package:flutte_scanner_empty/data/services/api_service.dart';
import 'package:flutte_scanner_empty/ui/auth/viewmodels/login_viewmodel.dart';
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
              apiService: ApiService(baseUrl: Configurations.mWebServiceUrl),
            ),
          ),
      child: child,
    );
  }
}
