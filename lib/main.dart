import 'package:flutte_scanner_empty/core/configurations.dart';
import 'package:flutte_scanner_empty/core/library.dart';
import 'package:flutte_scanner_empty/data/repository/gasto_repository.dart';
import 'package:flutte_scanner_empty/data/repository/user_repository.dart';
import 'package:flutte_scanner_empty/data/services/api_service.dart';
import 'package:flutte_scanner_empty/data/services/supabase_auth_service.dart';
import 'package:flutte_scanner_empty/data/services/local_service.dart';
import 'package:flutte_scanner_empty/ui/auth/login_page.dart';
import 'package:flutte_scanner_empty/ui/auth/login_viewmodel.dart';
import 'package:flutte_scanner_empty/ui/home/home_page.dart';
import 'package:flutte_scanner_empty/ui/home/home_viewmodel.dart';
import 'package:flutte_scanner_empty/ui/splash_page.dart';
import 'package:flutte_scanner_empty/providers/global_provider.dart';
import 'package:flutte_scanner_empty/ui/GastosForm/form_gasto_page.dart';
import 'package:flutte_scanner_empty/ui/GastosForm/form_gasto_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Le indica a Flutter que ejecute la app definida en MyApp.
Future<void> main() async {
  await Supabase.initialize(
    url: Configurations.mSupabaseUrl,
    anonKey: Configurations.mSupabaseKey,
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalProvider()),
        ChangeNotifierProvider(
          create:
              (_) => LoginViewModel(
                SupabaseAuthService(),
                userRepository: UserRepository(
                  apiService: ApiService(
                    baseUrl: Configurations.mWebServiceUrl,
                  ),
                ),
              ),
          child: LoginPage(),
        ),
        ChangeNotifierProvider(
          create:
              (_) => HomeViewModel(
                SupabaseAuthService(),
                gastoRepository: GastoRepository(
                  localService: LocalService(),
                ),
              )..getGastos(),
          child: HomePage(),
        ),
        ChangeNotifierProvider(
          create: (_) => FormGastosViewModel(),
          child: FormGastosPage(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

// Crea un estado de toda la app,
// le asigna un nombre a la app,
// define el tema visual y
// establece el widget "principal" (el punto de partida de tu app).
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('es'), Locale('en')],
      debugShowCheckedModeBanner: false,
      title: 'MAC GastosApp',
      navigatorObservers: [mRouteObserver],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        fontFamily: 'Inter',
      ),
      home: const SplashPage(),
    );
  }
}
