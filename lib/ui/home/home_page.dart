import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/ui/home/widgets/add_gasto_button.dart';
import 'package:flutte_scanner_empty/ui/home/widgets/home_body.dart';
import 'package:flutte_scanner_empty/ui/home/widgets/home_drawer.dart';
import 'package:flutte_scanner_empty/ui/widgets/navbar_back.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddGastoButton(),
      appBar: _buildAppBar(),
      drawer: HomeDrawer(),
      body: HomeBody(),
    );
  }

  // AppBar personalizada
  NavbarBack _buildAppBar() {
    return NavbarBack(
      backgroundColor: Constants.colourBackgroundColor,
      backgroundButtonColor: Constants.colourActionPrimary,
      tinte: Tinte.light,
      title: "Gastos",
      showBack: false,
      showMenu: true,
      mListActions: [
        Image.asset(
          "assets/icon/logoartero(pequenyo).webp",
          height: 40,
          width: 40,
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
