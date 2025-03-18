import 'dart:developer';

import 'package:flutte_scanner_empty/source/custom/constants.dart';
import 'package:flutte_scanner_empty/source/custom/library.dart';
import 'package:flutte_scanner_empty/source/models/country_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
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
                    Text("Paises", style: Constants.typographyHeadingL),
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
                            onTap: () => {},
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // body: Container(
      //   color: Constants.colourBackgroundColor,
      //   width: double.infinity,
      //   height: double.infinity,
      //   alignment: Alignment.center,
      //   child: Column(
      //     children: [
      //       const SizedBox(height: 100),
      //       Text(
      //         mOnBoarding,
      //         style: TextStyle(
      //           fontSize: 50,
      //           fontWeight: FontWeight.w800,
      //           color: Colors.red,
      //         ),
      //       ),
      //       Text(
      //         Configurations.mVersion,
      //         style: TextStyle(
      //           fontSize: 50,
      //           fontWeight: FontWeight.w800,
      //           color: Constants.colourTextDefault,
      //         ),
      //       ),
      //       Text(
      //         Provider.of<GlobalProvider>(context, listen: false).mToken,
      //         style: TextStyle(
      //           fontSize: 50,
      //           fontWeight: FontWeight.w800,
      //           color: Colors.green,
      //         ),
      //       ),
      //       MaterialButton(
      //         onPressed: () {
      //           Provider.of<GlobalProvider>(context, listen: false).mToken =
      //               "Ouch!!";
      //           setState(() {});
      //         },
      //         color: Constants.colourActionPrimary,
      //         child: const Text('¡Click me!'),
      //       ),
      //       MaterialButton(
      //         onPressed: () {
      //           globalContext = context;
      //           navigate(globalContext!, CustomPage.details);
      //         },
      //         color: Constants.colourActionStatusPressedPrimary,
      //         child: const Text('¡Go details!'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
