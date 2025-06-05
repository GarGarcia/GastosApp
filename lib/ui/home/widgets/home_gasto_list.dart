import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/core/library.dart';
import 'package:flutte_scanner_empty/ui/form/form_gasto_viewmodel.dart';
import 'package:flutte_scanner_empty/ui/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:provider/provider.dart';

class HomeGastoList extends StatelessWidget {
  const HomeGastoList({super.key});

  @override
  Widget build(BuildContext context) {
    final view = context.watch<HomeViewModel>();

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: view.gastosList.length,
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
              context.read<FormGastoViewModel>().clear();
              context.read<FormGastoViewModel>().initWithGlobalProvider(
                view.gastosList[index],
              );
              navigate(context, CustomPage.formGasto);
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
                      TablerIcons.moneybag,
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
                          view.gastosList[index].gastoModelDescription!,
                          style: Constants.typographyBlackBoldM,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Importe: ${view.gastosList[index].gastoModelImport} €",
                          style: Constants.typographyBlackBodyM,
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
}