import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/core/library.dart';
import 'package:flutte_scanner_empty/ui/form/form_gasto_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:provider/provider.dart';
import '../../../data/models/gasto_model.dart';

class GastosItem extends StatelessWidget {
  final GastoModel gasto;
  const GastosItem({required this.gasto, super.key});

  @override
  Widget build(BuildContext context) {
    // Tu Card personalizada para mostrar el gasto
    return Card(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: InkWell(
        onTap: () {
          context.read<FormGastoViewModel>().clear();
          context.read<FormGastoViewModel>().initWithGlobalProvider(
            gasto,
          );
          navigate(context, CustomPage.formCountry);
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
                      gasto.mGastoModelDescription!,
                      style: Constants.typographyBlackBoldM,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Importe: ${gasto.mGastoModelImport} €",
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
  }
}
