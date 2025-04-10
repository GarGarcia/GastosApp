import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/core/library.dart';
import 'package:flutte_scanner_empty/ui/widgets/custom_drawer_label.dart';
import 'package:flutte_scanner_empty/ui/widgets/navbar_back.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavbarBack(
        backgroundColor: Constants.colourBackgroundColor,
        backgroundButtonColor: Constants.colourActionPrimary,
        tinte: Tinte.light,
        title: "Tickets",
        showBack: true,
        showMenu: false,
        mListActions: [
          Image.asset(
            "assets/icon/logoartero(pequenyo).png",
            height: 40,
            width: 40,
          ),
          const SizedBox(width: 10),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.only(top: 50, left: 15, right: 10),
          children: [
            Image.asset(
              'assets/icon/logoartero3.png',
              height: 30,
              width: 30,
              alignment: Alignment.centerLeft,
            ),
            const SizedBox(height: 15),
            Divider(color: Constants.globalColorNeutral30),
            const SizedBox(height: 15),
            CustomDrawerLabel(
              method: () async {
                globalContext = context;
                navigate(globalContext!, CustomPage.profilePage);
              },
              icon: Icon(Icons.account_circle),
              title: 'Perfil',
            ),
            const SizedBox(height: 15),
            Divider(color: Constants.globalColorNeutral30),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {},
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
                  SizedBox(width: 10),
                  Text("Cerrar Sesión", style: Constants.typographyDangerBoldM),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Divider(color: Constants.globalColorNeutral30),
          ],
        ),
      ),
    );
  }
}
