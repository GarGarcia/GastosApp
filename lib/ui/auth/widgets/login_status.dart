import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../login_viewmodel.dart';

class LoginStatus extends StatelessWidget {
  const LoginStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();
    if (vm.errorMessage != null && vm.errorMessage!.isNotEmpty) {
      return Text(vm.errorMessage!, style: const TextStyle(color: Colors.red));
    }
    return const SizedBox.shrink();
  }
}
