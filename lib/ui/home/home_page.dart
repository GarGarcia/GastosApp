import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/core/library.dart';
import 'package:flutte_scanner_empty/data/models/ticket_model.dart';
import 'package:flutte_scanner_empty/ui/home/home_viewmodel.dart';
import 'package:flutte_scanner_empty/ui/widgets/custom_button.dart';
import 'package:flutte_scanner_empty/ui/widgets/custom_drawer_label.dart';
import 'package:flutte_scanner_empty/ui/widgets/navbar_back.dart';
import 'package:flutte_scanner_empty/providers/global_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos context.watch para acceder a HomeViewModel
    final view = context.watch<HomeViewModel>();
    final globalProvider = context.read<GlobalProvider>();

    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(context, globalProvider),
      appBar: _buildAppBar(),
      drawer: _buildDrawer(context, view),
      body: _buildBody(context, view),
    );
  }

  // Botón flotante
  Widget _buildFloatingActionButton(
    BuildContext context,
    GlobalProvider globalProvider,
  ) {
    return FloatingActionButton(
      backgroundColor: Constants.colourActionPrimary,
      child: CustomButton(
        color: Colors.transparent,
        width: 50,
        child: Icon(
          TablerIcons.plus,
          color: Constants.colourActionSecondary,
          size: 25,
        ),
      ),
      onPressed: () async {
        globalProvider.mTicket = TicketModel();
        _goToFormTicket(context);
      },
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
          "assets/icon/logoartero(pequenyo).png",
          height: 40,
          width: 40,
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  // Drawer del menú lateral
  Widget _buildDrawer(BuildContext context, HomeViewModel view) {
    return Drawer(
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
              navigate(context, CustomPage.profilePage);
            },
            icon: Icon(Icons.account_circle),
            title: 'Perfil',
          ),
          const SizedBox(height: 15),
          Divider(color: Constants.globalColorNeutral30),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () {
              view.logOut();
              Navigator.pop(context);
              navigate(context, CustomPage.loginPage);
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
                SizedBox(width: 10),
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

  // Cuerpo principal con la lista de tickets
  Widget _buildBody(BuildContext context, HomeViewModel view) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: RefreshIndicator(
        backgroundColor: Constants.colourBackgroundColor,
        color: Constants.colourTextColor,
        strokeWidth: 3,
        displacement: 80,
        onRefresh: () async {
          await view.getGastos();
        },
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(width: 20, height: 20),
                view.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : view.ticketList.isEmpty
                    ? Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                      ),
                      width: double.infinity,
                      child: Text(
                        "No hay registros para mostrar",
                        style: Constants.typographyBoldL,
                        textAlign: TextAlign.center,
                      ),
                    )
                    : _buildTicketList(context, view),
                SizedBox(height: 40),
                Text(view.getEmail() ?? "No hay email"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Lista de tickets
  Widget _buildTicketList(BuildContext context, HomeViewModel view) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: view.ticketList.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: InkWell(
            onTap: () {
              globalContext = context;
              context.read<GlobalProvider>().mTicket = view.ticketList[index];
              _goToFormTicket(context);
            },
            borderRadius: BorderRadius.circular(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: Container(
                    width: 40,
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: Icon(
                      TablerIcons.map_pin,
                      color: Constants.colourIconColor,
                      size: Constants.globalIconSizeL,
                    ),
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    width: double.infinity,
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          view.ticketList[index].mTicketModelDescription!,
                          style: Constants.typographyBoldM,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Importe: ${view.ticketList[index].mTicketModelImport} €",
                          style: Constants.typographyBodyM,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                  height: 70,
                  child: Container(
                    width: 40,
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: Icon(
                      TablerIcons.chevron_right,
                      color: Constants.colourIconColor,
                      size: Constants.globalIconSizeM,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _goToFormTicket(BuildContext context) async {
    final view = context.read<HomeViewModel>();

    final result = await navigate(context, CustomPage.formCountry);

    if (result == true) {
      await view.getGastos();
    }
  }
}