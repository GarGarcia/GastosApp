import 'dart:async';

import 'package:flutte_scanner_empty/source/custom/constants.dart';
import 'package:flutte_scanner_empty/source/custom/library.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startTime(CustomPage mPage) async {
    Timer(const Duration(seconds: 3), () {
      navigate(context, CustomPage.home);
    });
  }

  @override
  void initState() {
    super.initState();

    globalContext = context;

    startTime(CustomPage.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Constants.colourBackgroundOncolor,
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: const Text(
          'GastosApp',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
