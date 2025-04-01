import 'package:flutte_scanner_empty/source/custom/constants.dart';
import 'package:flutte_scanner_empty/source/custom/library.dart';
import 'package:flutte_scanner_empty/source/custom/validation.dart';
import 'package:flutte_scanner_empty/source/widgets/custom_button.dart';
import 'package:flutte_scanner_empty/source/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(right: 20, left: 20),
        child: Column(
          children: [
            Text('¡Bienvenido!', style: Constants.typographyHeadingM),
            SizedBox(height: 20),
            Text(
              'Para acceder a la aplicación, introduce tu cuenta de correo de la empresa',
              style: Constants.typographyBodyS,
            ),
            SizedBox(height: 20),
            Form(
              child: Column(
                children: [
                  CustomInput(title: 'Correo electrónico', validator: () {}),
                ],
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
              color: Constants.colourActionPrimary,
              callback: () {},
              child: Text('Siguiente', style: Constants.typographyButtonM),
            ),
          ],
        ),
      ),
    );
  }
}
