import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/core/library.dart';
import 'package:flutte_scanner_empty/data/models/gasto_model.dart';
import 'package:flutte_scanner_empty/ui/form/form_gasto_viewmodel.dart';
import 'package:flutte_scanner_empty/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:provider/provider.dart';

class AddGastoButton extends StatelessWidget {
  const AddGastoButton({super.key});

  @override
  Widget build(BuildContext context) {
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
      onPressed: () {
        context.read<FormGastoViewModel>().clear();
        context.read<FormGastoViewModel>().initWithGlobalProvider(GastoModel());
        navigate(context, CustomPage.formGasto);
      },
    );
  }
}