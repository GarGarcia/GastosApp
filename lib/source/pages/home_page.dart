import 'package:flutte_scanner_empty/source/custom/configuration.dart';
import 'package:flutte_scanner_empty/source/custom/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
 }

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Constants.colourBackgroundColor,
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Text(
          Configuration.mVersion, 
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w800
          ),
        ),
      ),
    );
  }
}