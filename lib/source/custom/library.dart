import 'package:flutte_scanner_empty/source/pages/home_page.dart';
import 'package:flutte_scanner_empty/source/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CustomPage { splash, home }

enum TypeAnimation { transition }

enum Preference { onboarding }

BuildContext? globalContext;

navigate(
  BuildContext mContext,
  CustomPage mPage, {
  bool finishCurrent = false,
}) {
  if (finishCurrent) {
    Navigator.pop(globalContext!);
  }

  switch (mPage) {
    case CustomPage.splash:
      Navigator.pushAndRemoveUntil(
        globalContext!,
        _goPage(const SplashPage(), TypeAnimation.transition, 500),
        (Route<dynamic> route) => false,
      );
      break;
    case CustomPage.home:
      Navigator.pushAndRemoveUntil(
        globalContext!,
        _goPage(const HomePage(), TypeAnimation.transition, 500),
        (Route<dynamic> route) => false,
      );
      break;
  }
}

Route _goPage(Widget page, TypeAnimation type, int miliseconds) {
  return PageRouteBuilder(
    pageBuilder:
        (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) => page,
    transitionDuration: Duration(milliseconds: miliseconds),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final mCurveAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInBack,
      );

      switch (type) {
        case TypeAnimation.transition:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(mCurveAnimation),
            child: child,
          );
      }
    },
  );
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write("ff");
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  //String toHex ({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}';
  // '${alpha.toRadixString(16).padLeft(2, '0')}'
  // '${red.toRadixString(16).padLeft(2, '0')}'
  // '${green.toRadixString(16).padLeft(2, '0')}'
  // '${blue.toRadixString(16).padLeft(2, '0')}'
  // ;
}

setOnePreference(Preference mAuxKey, String value) async {
  String mkey = '';
  switch(mAuxKey){
    case Preference.onboarding:
      mkey = 'onboarding';
      break;
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(mkey, value);
}

getOnePreference(Preference mAuxKey) async {
  String mkey = '';
  switch(mAuxKey){
    case Preference.onboarding:
      mkey = 'onboarding';
      break;
  }

  // ignore: unused_local_variable
  String result = "";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool checkValue = prefs.containsKey(mkey);
  if(checkValue){
    result = prefs.getString(mkey) ?? '';
  }
}