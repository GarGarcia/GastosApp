import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../login_viewmodel.dart';
import '../../../core/library.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const LoginButton({required this.formKey, super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: vm.isLoading
            ? null
            : () async {
                if (formKey.currentState?.validate() ?? false) {
                  String? messageError = await vm.login();
                  if (!context.mounted) return;
                  if (messageError != "") {
                    customShowToast(context, messageError);
                    return;
                  }
                  navigate(context, CustomPage.home);
                }
              },
        child: vm.isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text('Entrar'),
      ),
    );
  }
}
