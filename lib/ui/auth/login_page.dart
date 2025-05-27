import 'package:flutte_scanner_empty/core/constants.dart';
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
  Validation _validation = Validation();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = context.watch<LoginViewModel>();

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(20),
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
                CustomButton(
                  color: Constants.colourActionPrimary,
                  callback: () {
                    loginViewModel.login(context);
                  },
                  child: Text('Entrar', style: Constants.typographyButtonM),
                ),
                const SizedBox(height: 20),
                Center(child: loginViewModel.data()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
