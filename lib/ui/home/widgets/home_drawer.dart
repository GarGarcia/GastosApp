import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/core/library.dart';
import 'package:flutte_scanner_empty/ui/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.only(top: 50, left: 15, right: 10),
        children: [
          Image.asset(
            'assets/icon/logoartero3.webp',
            height: 30,
            width: 30,
            alignment: Alignment.centerLeft,
          ),
          const SizedBox(height: 15),
          Divider(color: Constants.globalColorNeutral30),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () async {
              HomeViewModel view = context.read<HomeViewModel>();
              await view.logOut();
              if(context.mounted) {
                if (view.errorMessage != "") {
                  Navigator.pop(context);
                  customShowToast(context, view.errorMessage);
                } else {
                  Navigator.pop(context);
                  navigate(context, CustomPage.loginPage, finishCurrent: true);
                }
              }
              
            },
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Constants.globalColorNeutral20,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 30,
                  width: 30,
                  child: Icon(
                    Icons.logout,
                    color: Constants.colourSemanticDanger1,
                  ),
                ),
                const SizedBox(width: 10),
                Text("Cerrar Sesión", style: Constants.typographyDangerBoldM),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Divider(color: Constants.globalColorNeutral30),
        ],
      ),
    );
  }
}