import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/core/library.dart';
import 'package:flutte_scanner_empty/ui/form/form_gasto_viewmodel.dart';
import 'package:flutte_scanner_empty/ui/home/home_viewmodel.dart';
import 'package:flutte_scanner_empty/ui/widgets/custom_button.dart';
import 'package:flutte_scanner_empty/ui/widgets/navbar_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:provider/provider.dart';

class FormGastoNavbar extends StatelessWidget implements PreferredSizeWidget {
  const FormGastoNavbar({super.key})
    : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    final FormGastoViewModel vm = context.watch<FormGastoViewModel>();

    return NavbarBack(
      backgroundColor: Constants.colourBackgroundColor,
      backgroundButtonColor: Constants.colourActionPrimary,
      tinte: Tinte.light,
      title: vm.editingGasto.mIdx == null ? "Nuevo Gasto" : "Editar Gasto",
      showBack: true,
      showMenu: false,
      mListActions: [
        vm.editingGasto.mIdx == null
            ? const SizedBox()
            : CustomButton(
                color: Colors.transparent,
                width: 50,
                callback: () {
                  _deleteConfirmation(context, vm);
                },
                child: Icon(
                  TablerIcons.trash,
                  color: Constants.colourActionPrimary,
                  size: 25,
                ),
              ),
      ],
    );
  }

  void _deleteConfirmation(BuildContext context, FormGastoViewModel vm) {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      backgroundColor: Constants.colourBackgroundColor,
      builder: (BuildContext context) {
        return Container(
          color: Constants.colourBackgroundColor,
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Eliminar gasto',
                  style: Constants.typographyHeadingM,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '¿Quieres eliminar el gasto?',
                style: Constants.typographyBodyM,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: CustomButton(
                      width: double.infinity,
                      color: Constants.colourActionSecondary,
                      callback: () => Navigator.pop(context),
                      child: Text(
                        "Atrás",
                        style: Constants.typographyButtonMSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    flex: 1,
                    child: CustomButton(
                      width: double.infinity,
                      color: Constants.colourActionPrimary,
                      callback: () async {
                        final result = await vm.deleteGasto(context);
                        if (!context.mounted) {
                          return;
                        }
                        if (result != null) {
                          customShowToast(context, result);
                          context.read<HomeViewModel>().getGastos();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Eliminar",
                        style: Constants.typographyButtonM,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
