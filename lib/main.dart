import 'package:flutte_scanner_empty/source/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Le indica a Flutter que ejecute la app definida en MyApp.
void main() {
  runApp(MyApp());
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
        title: 'MAC Invoice Scanner',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          textTheme: GoogleFonts.interTextTheme(),
        ),
        home: const SplashPage()
    );
  }
}