import 'dart:developer';

import 'package:flutte_scanner_empty/source/custom/constants.dart';
import 'package:flutte_scanner_empty/source/custom/library.dart';
import 'package:flutte_scanner_empty/source/models/country_model.dart';
import 'package:flutte_scanner_empty/source/providers/global_provider.dart';
// import 'package:flutte_scanner_empty/source/widgets/custom_button.dart';
import 'package:flutte_scanner_empty/source/widgets/navbar_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String mOnBoarding = '';
  Countries mCountries = Countries();
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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(FocusNode());
      getCountries();
    });
  }

  getCountries() async {
    // Get a reference your Supabase client
    final mSupabase = Supabase.instance.client;
    final mResult = await mSupabase.from('countries').select();
    log("==> mResult: $mResult");

    mCountries = Countries.fromJsonList(mResult);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavbarBack(
        backgroundColor: Constants.colourBackgroundColor,
        backgroundButtonColor: Constants.colourActionPrimary,
        tinte: Tinte.light,
        title: "Países",
        showBack: false,
        showMenu: true,
        mListActions: [],
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
              getCountries();
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
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: mCountries.items.length,
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
                              Provider.of<GlobalProvider>(context, listen: false).mCountry = mCountries.items[index];
                              navigate(globalContext!, CustomPage.details);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          mCountries.items[index].mCountryName!,
                                          style: Constants.typographyBoldM,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "Código ${mCountries.items[index].mCountryCode}",
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
                    // Container(
                    //   margin: EdgeInsets.only(left: 10, right: 10),
                    //   child: CustomButton(
                    //     color: Constants.colourActionPrimary,
                    //     callback: () {},
                    //     child: Text(
                    //       'Click',
                    //       style: Constants.typographyButtonM,
                    //     ),
                    //   ),
                    // ),
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
