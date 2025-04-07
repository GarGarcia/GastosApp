import 'package:flutte_scanner_empty/source/custom/configurations.dart';
import 'package:flutte_scanner_empty/source/custom/constants.dart';
import 'package:flutte_scanner_empty/source/custom/library.dart';
import 'package:flutte_scanner_empty/source/data/services/api_service.dart';
import 'package:flutte_scanner_empty/source/models/user_model.dart';
import 'package:flutte_scanner_empty/source/widgets/custom_button.dart';
import 'package:flutte_scanner_empty/source/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<UserModel?>? userData;
  ApiService apiService = ApiService(baseUrl: Configurations.mWebServiceUrl);

  late String username;
  late String password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: RefreshIndicator(
          backgroundColor: Constants.colourBackgroundColor,
          color: Constants.colourTextColor,
          strokeWidth: 3,
          displacement: 80,
          onRefresh: () async {
            if (mounted) {
              globalContext = context;
            }
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(20),
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
                      const SizedBox(width: 20, height: 20),
                      CustomInput(
                        title: "Usuario",
                        textInputType: TextInputType.text,
                        validator: (value) {
                          setState(() {
                            username = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomInput(
                        title: "Contraseña",
                        textInputType: TextInputType.text,
                        validator: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        obscurePassword: true,
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  color: Constants.colourActionPrimary,
                  callback: () {
                    setState(() {
                      userData = apiService.login(username, password);
                    });
                  },
                  child: Text('Siguiente', style: Constants.typographyButtonM),
                ),
                FutureBuilder(
                  future: userData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      return Text(
                        "Token: ${snapshot.data?.accessToken}, Token type: ${snapshot.data?.tokenType}, Expires In: ${snapshot.data?.expiresIn}",
                      );
                    } else {
                      return Text("No hay resultados");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
