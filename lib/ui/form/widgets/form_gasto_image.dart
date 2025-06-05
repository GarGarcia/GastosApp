import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/ui/form/form_gasto_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormGastoImage extends StatelessWidget {
  const FormGastoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FormGastoViewModel>(
      builder: (context, vm, child) {
        return Center(
          heightFactor: 1,
          child:
              (vm.editingGasto.gastoModelImageUrl == null ||
                      vm.editingGasto.gastoModelImageUrl!.isEmpty) &&
                  vm.image == null
              ? Text(
                  "Gasto no escaneado",
                  style: Constants.typographyBlackBodyL,
                )
              : SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: vm.image != null
                      ? Image.file(vm.image!)
                      : Image.network(
                          vm.editingGasto.gastoModelImageUrl!,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                    : null,
                              ),
                            );
                          },
                        ),
                ),
        );
      },
    );
  }
}
