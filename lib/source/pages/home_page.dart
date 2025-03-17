import 'dart:developer';

import 'package:flutte_scanner_empty/source/custom/configurations.dart';
import 'package:flutte_scanner_empty/source/custom/constants.dart';
import 'package:flutte_scanner_empty/source/custom/library.dart';
import 'package:flutte_scanner_empty/source/providers/global_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String mOnBoarding = '';
  @override
  void initState() {
    super.initState();

    getOnePreference(Preference.onboarding).then((dynamic result) {
      log("==> result: $result");
      mOnBoarding = result;

      setState(() {});

      if (result == "") {
        setOnePreference(Preference.onboarding, "true");
        log("==> mOnBoarding: $mOnBoarding");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Constants.colourBackgroundColor,
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 100),
            Text(
              mOnBoarding,
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w800,
                color: Colors.red,
              ),
            ),
            Text(
              Configurations.mVersion,
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w800,
                color: Constants.colourTextDefault,
              ),
            ),
            Text(
              Provider.of<GlobalProvider>(context, listen: false).mToken,
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w800,
                color: Colors.green,
              ),
            ),
            MaterialButton(
              onPressed: () {
                Provider.of<GlobalProvider>(context, listen: false).mToken =
                    "Ouch!!";
                setState(() {});
              },
              color: Constants.colourActionPrimary,
              child: const Text('¡Click me!'),
            ),
            MaterialButton(
              onPressed: () {
                globalContext = context;
                navigate(globalContext!, CustomPage.details);
              },
              color: Constants.colourActionStatusPressedPrimary,
              child: const Text('¡Go details!'),
            ),
          ],
        ),
      ),
    );
  }
}
