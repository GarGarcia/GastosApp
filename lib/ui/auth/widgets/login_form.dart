import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../login_viewmodel.dart';
import 'login_button.dart';
import '../../../core/validation.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _validation = Validation();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: "Usuario"),
            onChanged: (value) => vm.username = value,
            validator: (value) => _validation.validate(
              type:
                  TypeValidation.email, // O TypeValidation.text si no es email
              name: "Usuario",
              value: value,
              isRequired: true,
              min: 3,
              max: 50,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(labelText: "Contraseña"),
            obscureText: true,
            onChanged: (value) => vm.password = value,
            validator: (value) => _validation.validate(
              type: TypeValidation.pass,
              name: "Contraseña",
              value: value,
              isRequired: true,
              min: 6,
              max: 50,
            ),
          ),
          const SizedBox(height: 20),
          LoginButton(formKey: _formKey),
        ],
      ),
    );
  }
}
