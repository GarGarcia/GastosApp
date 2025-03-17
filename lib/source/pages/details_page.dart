import 'package:flutte_scanner_empty/source/custom/constants.dart';
import 'package:flutte_scanner_empty/source/custom/library.dart';
import 'package:flutte_scanner_empty/source/providers/global_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Constants.colourBackgroundDark,
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 100),
            Text(
              "Details Page",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w800,
                color: Constants.colourTextColor,
              ),
            ),
            Text(
              Provider.of<GlobalProvider>(context, listen: false).mToken,
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w800,
                color: Constants.colourTextColor,
              ),
            ),
            MaterialButton(
              onPressed: () {
                globalContext = context;
                navigate(globalContext!, CustomPage.home);
              },
              color: Constants.colourActionStatusPressedPrimary,
              child: const Text('¡Go home!'),
            ),
          ],
        ),
      ),
    );
  }
}
