import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/ui/form/form_gasto_viewmodel.dart';
import 'package:flutte_scanner_empty/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormGastoCameraButton extends StatelessWidget {
  const FormGastoCameraButton({super.key});

  @override
  Widget build(BuildContext context) {
    final FormGastoViewModel vm = context.watch<FormGastoViewModel>();

    return FloatingActionButton(
      onPressed: () => _pickOption(context, vm),
      backgroundColor: Constants.colourActionPrimary,
      child: CustomButton(
        color: Colors.transparent,
        width: 50,
        child: Icon(
          Icons.camera_alt,
          color: Constants.colourActionSecondary,
          size: 25,
        ),
      ),
    );
  }

  void _pickOption(BuildContext context, FormGastoViewModel vm) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Escanear Gastos", style: Constants.typographyBlackBodyL),
          content: SingleChildScrollView(
            child: Text(
              'Elije una opción para escanear el Gastos',
              style: Constants.typographyBlackBodyM,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                vm.pickImage("galeria");
                Navigator.of(context).pop();
              },
              child: Text("Galeria", style: Constants.typographyBoldM),
            ),
            TextButton(
              onPressed: () {
                vm.pickImage("camara");
                Navigator.of(context).pop();
              },
              child: Text("Camara", style: Constants.typographyBoldM),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close", style: Constants.typographyDangerBoldM),
            ),
          ],
        );
      },
    );
  }
}