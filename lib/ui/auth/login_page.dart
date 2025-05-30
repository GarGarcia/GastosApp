import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/core/library.dart';
import 'package:flutte_scanner_empty/core/validation.dart';
import 'package:flutte_scanner_empty/ui/auth/login_viewmodel.dart';
import 'package:flutte_scanner_empty/ui/widgets/custom_button.dart';
import 'package:flutte_scanner_empty/ui/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Validation _validation = Validation();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginViewModel = context.watch<LoginViewModel>();

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text("¡Bienvenido!", style: Constants.typographyDarkHeadingM),
                const SizedBox(height: 20),
                Text(
                  "Para acceder a la aplicación, introduce usuario y contraseña.",
                  style: Constants.typographyBlackBodyM,
                ),
                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CustomInput(
                        title: "Usuario",
                        textInputType: TextInputType.text,
                        validator: (value) {
                          loginViewModel.username = value;
                          return _validation.validate(
                            type: TypeValidation.email,
                            name: "Usuario",
                            value: value,
                            isRequired: true,
                            max: 30,
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomInput(
                        title: "Contraseña",
                        textInputType: TextInputType.text,
                        validator: (value) {
                          loginViewModel.password = value;
                          return _validation.validate(
                            type: TypeValidation.pass,
                            name: "Contraseña",
                            value: value,
                            isRequired: true,
                            max: 30,
                          );
                        },
                        obscurePassword: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    color: Constants.colourActionPrimary,
                    callback: loginViewModel.isLoading
                        ? null
                        : () async {
                            // Validación antes de login
                            if (_formKey.currentState?.validate() ?? false) {
                              String? messageError = await loginViewModel
                                  .login();
                              if (!context.mounted) return;
                              if (messageError != "") {
                                customShowToast(context, messageError);
                                return;
                              }
                              navigate(context, CustomPage.home);
                            }
                          },
                    child: loginViewModel.isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text('Entrar', style: Constants.typographyButtonM),
                  ),
                ),
                const SizedBox(height: 20),
                if (loginViewModel.errorMessage != null &&
                    loginViewModel.errorMessage!.isNotEmpty)
                  Center(
                    child: Text(
                      loginViewModel.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
