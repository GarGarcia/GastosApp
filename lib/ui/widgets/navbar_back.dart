import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

enum Tinte { dark, light }

class NavbarBack extends StatelessWidget implements PreferredSizeWidget {
  const NavbarBack({
    super.key,
    this.title,
    this.backgroundColor,
    this.backgroundButtonColor,
    this.tinte,
    this.showBack = false,
    this.showMenu = false,
    this.goBack,
    this.mListActions,
    this.menu,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  final String? title;
  final Color? backgroundColor;
  final Color? backgroundButtonColor;
  final Tinte? tinte;
  final bool? showBack;
  final bool? showMenu;
  final Function? goBack;
  final List<Widget>? mListActions;
  final Widget? menu;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:
            (tinte == Tinte.light
                ? Constants.globalColorSemanticsBlue50
                : Constants.globalColorSemanticsBlue80),
        statusBarIconBrightness:
            (tinte == Tinte.light
                ? Brightness.light
                : Brightness.dark),
        statusBarBrightness:
            (tinte == Tinte.light
                ? Brightness.light
                : Brightness.dark),
      ),
      surfaceTintColor: (backgroundColor ?? Constants.colourBackgroundColor),
      backgroundColor: (backgroundColor ?? Constants.colourBackgroundColor),
      iconTheme: const IconThemeData(),
      centerTitle: true,
      title: Container(
        color: (backgroundColor ?? Constants.colourBackgroundColor),
        child: Text(
          (title == null ? "" : title!),
          style:
              (tinte == Tinte.light
                  ? Constants.typographyBoldL
                  : Constants.typographyBoldL),
          textAlign: TextAlign.center,
        ),
      ),
      elevation: 0,
      leading:
          (showBack == true
              ? CustomButton(
                color: Colors.transparent,
                child: Icon(
                  TablerIcons.chevron_left,
                  color:
                      (tinte == Tinte.light
                          ? Constants.colourActionPrimary
                          : Constants.colourActionSecondary),
                  size: 22,
                ),
                callback: () {
                  Navigator.of(context).pop();
                  if (goBack != null) {
                    goBack!();
                  }
                },
              )
              : (showMenu == true
                  ? CustomButton(
                    color: Colors.transparent,
                    child: Icon(
                      Icons.menu,
                      color:
                          (tinte == Tinte.light
                              ? Constants.colourActionPrimary
                              : Constants.colourActionSecondary),
                      size: 22,
                    ),
                    callback: () => Scaffold.of(context).openDrawer(),
                  )
                  : null)),
      actions: mListActions,
    );
  }
}
