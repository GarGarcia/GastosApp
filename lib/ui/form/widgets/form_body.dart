import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/core/library.dart';
import 'package:flutte_scanner_empty/ui/form/form_gasto_viewmodel.dart';
import 'package:flutte_scanner_empty/ui/form/widgets/form_gasto_fields.dart';
import 'package:flutte_scanner_empty/ui/form/widgets/form_gasto_image.dart';
import 'package:flutte_scanner_empty/ui/home/home_viewmodel.dart';
import 'package:flutte_scanner_empty/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormBody extends StatelessWidget {
  const FormBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FormGastoViewModel>(
      builder: (context, vm, _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: vm.isLoading
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: const Center(child: CircularProgressIndicator()),
                    )
                  : Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          FormGastoFields(),
                          FormGastoImage(),
                          const SizedBox(height: 20),
                          CustomButton(
                            color: Constants.colourActionPrimary,
                            callback: () async {
                              final result = await vm.saveGasto(context);
                              if (!context.mounted) return;
                              if (result != null) {
                                customShowToast(context, result);
                                context.read<HomeViewModel>().getGastos();
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'Guardar',
                              style: Constants.typographyButtonM,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
