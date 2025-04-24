import 'dart:developer';

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

class HomePage extends StatefulWidget {
  final HomeViewModel homeViewModel;
  const HomePage({super.key, required this.homeViewModel});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  String mOnBoarding = '';
  List<TicketModel> mTickets = [];

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

    getGastos();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mRouteObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    mRouteObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    log('HomePage fue empujada');
  }

  @override
  void didPopNext() {
    log('HomePage es ahora visible');
    getGastos();
  }

  getGastos() async {

    progressDialogShow(globalContext!);
    await widget.homeViewModel.getGastos();
    dialogDismiss();
    
    mTickets = widget.homeViewModel.ticketList;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
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
          globalContext = context;
          Provider.of<GlobalProvider>(context, listen: false).mTicket =
              TicketModel();
          navigate(globalContext!, CustomPage.formCountry);
        },
      ),
      appBar: NavbarBack(
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
              onPressed: () {
                widget.homeViewModel.logOut();
                globalContext = context;
                Navigator.pop(globalContext!);
                navigate(globalContext!, CustomPage.loginPage);
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
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: RefreshIndicator(
          backgroundColor: Constants.colourBackgroundColor,
          color: Constants.colourTextColor,
          strokeWidth: 3,
          displacement: 80,
          onRefresh: () async {
            if (mounted) {
              globalContext = context;
              getGastos();
            }
          },
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                child: Column(
                  children: [
                    const SizedBox(width: 20, height: 20),
                    mTickets.isEmpty
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
                        : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: mTickets.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                bottom: 10,
                              ),
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              color: Colors.white,
                              surfaceTintColor: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  globalContext = context;
                                  Provider.of<GlobalProvider>(
                                        context,
                                        listen: false,
                                      ).mTicket =
                                      mTickets[index];

                                  navigate(
                                    globalContext!,
                                    CustomPage.formCountry,
                                  );
                                },
                                borderRadius: BorderRadius.circular(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              mTickets
                                                  [index]
                                                  .mTicketModelClient!,
                                              style: Constants.typographyBoldM,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              "Importe: ${mTickets[index].mTicketModelImport}",
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
                        ),
                        SizedBox(height: 40,),
                        Text(widget.homeViewModel.getEmail() ?? "No hay email")
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
