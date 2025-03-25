import 'package:flutte_scanner_empty/source/custom/configurations.dart';
import 'package:flutte_scanner_empty/source/custom/library.dart';
import 'package:flutte_scanner_empty/source/pages/splash_page.dart';
import 'package:flutte_scanner_empty/source/providers/global_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// Le indica a Flutter que ejecute la app definida en MyApp.
Future<void> main() async {
  await Supabase.initialize(
    url: Configurations.mSupabaseUrl,
    anonKey: Configurations.mSupabaseKey,
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => GlobalProvider())],
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
      debugShowCheckedModeBanner: false,
      title: 'MAC Invoice Scanner',
      navigatorObservers: [mRouteObserver],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: const SplashPage(),
    );
  }
}
