import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/ui/auth/auth_gate.dart';
import 'package:flutte_scanner_empty/ui/form/form_gasto_page.dart';
import 'package:flutte_scanner_empty/ui/home/home_page.dart';
import 'package:flutte_scanner_empty/ui/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';

enum CustomPage { home, formGasto, loginPage, authGate }

enum TypeAnimation { transition }

enum Preference { onboarding }

final RouteObserver<ModalRoute<void>> mRouteObserver =
    RouteObserver<ModalRoute<void>>();

void navigate(
  BuildContext mContext,
  CustomPage mPage, {
  bool finishCurrent = false,
}) {
  if (finishCurrent) {
    Navigator.pop(mContext);
  }

  switch (mPage) {
    case CustomPage.home:
      Navigator.pushAndRemoveUntil(
        mContext,
        _goPage(HomePage(), TypeAnimation.transition, 500),
        (Route<dynamic> route) => false,
      );
      break;
    case CustomPage.formGasto:
      Navigator.push(
        mContext,
        _goPage(FormGastosPage(), TypeAnimation.transition, 500),
      );
      break;
    case CustomPage.loginPage:
      Navigator.pushAndRemoveUntil(
        mContext,
        _goPage(const LoginPage(), TypeAnimation.transition, 500),
        (Route<dynamic> route) => false,
      );
      break;
    case CustomPage.authGate:
      Navigator.push(
        mContext,
        _goPage(AuthGate(), TypeAnimation.transition, 500),
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
}

void customShowToast(BuildContext context, String message) {
  int mTime = (message.length / 3).round();
  mTime = mTime < 0 ? 1 : mTime;

  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: mTime,
    backgroundColor: Constants.colourBackgroundColor,
    textColor: Constants.colourTextColor,
    fontSize: Constants.globalTypographyFontSize75,
  ); 
}

void progressDialogShow(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
  OverlayLoadingProgress.start(
    context,
    barrierDismissible: false,
    widget: Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        padding: const EdgeInsets.only(top: 30),
        margin: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 10),
              blurRadius: 50,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Consultando...", style: Constants.typographyBoldL),
            SizedBox(
              height: 80,
              width: double.infinity,
              child: LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                colors: [Constants.globaColorPrimary70],
                strokeWidth: 2,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void dialogDismiss() {
  OverlayLoadingProgress.stop();
}
