import 'package:flutte_scanner_empty/core/configurations.dart';
import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/core/library.dart';
import 'package:flutte_scanner_empty/data/services/api_service.dart';
import 'package:flutte_scanner_empty/data/models/user_model.dart';
import 'package:flutte_scanner_empty/ui/widgets/custom_button.dart';
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
        // onTapCancel: () => FocusScope.of(context).unfocus(),
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
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Usuario",
                          border: OutlineInputBorder(),
                        ),
                        onChanged:
                            (value) => setState(() {
                              username = value;
                            }),
                      ),
                      // CustomInput(
                      //   title: "Usuario",
                      //   textInputType: TextInputType.text,
                      //   validator: (value) {
                      //     setState(() {
                      //       username = value;
                      //     });
                      //   },

                      // ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        obscuringCharacter: "*",
                        onChanged:
                            (value) => setState(() {
                              password = value;
                            }),
                      ),
                      // CustomInput(
                      //   title: "Contraseña",
                      //   textInputType: TextInputType.text,
                      //   validator: (value) {
                      //     setState(() {
                      //       password = value;
                      //     });
                      //   },
                      //   obscurePassword: true,
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                CustomButton(
                  color: Constants.colourActionPrimary,
                  callback: () {
                    // setState(() {
                    //   userData = apiService.login(username, password);
                    // });

                    navigate(globalContext!, CustomPage.home);
                  },
                  child: Text('Siguiente', style: Constants.typographyButtonM),
                ),
                const SizedBox(height: 20),
                Center(
                  child: FutureBuilder(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
