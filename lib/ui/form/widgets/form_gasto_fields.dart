import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/core/validation.dart';
import 'package:flutte_scanner_empty/ui/form/form_gasto_viewmodel.dart';
import 'package:flutte_scanner_empty/ui/form/widgets/form_gasto_field_fecha.dart';
import 'package:flutte_scanner_empty/ui/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormGastoFields extends StatelessWidget {
  const FormGastoFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FormGastoViewModel>(
      builder: (context, vm, child) {
        return Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: vm.formKey,
          child: Column(
            children: [
              const SizedBox(width: 20, height: 20),
              FormGastoFieldFecha(vm: vm),
              const SizedBox(height: 10),
              CustomInput(
                title: "Importe",
                controller: vm.importController,
                textInputType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  return vm.validation.validate(
                    type: TypeValidation.dec,
                    name: "Importe",
                    value: vm.importController.text,
                    isRequired: true,
                    max: 15,
                  );
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<Cliente>(
                menuMaxHeight: 225,
                value: vm.selectedCliente,
                decoration: InputDecoration(
                  labelText: 'Cliente',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Constants.globalColorNeutral70,
                      width: 1,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Constants.colourSemanticDanger1,
                      width: 1,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Constants.colourSemanticDanger1,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Constants.colourActionPrimary,
                      width: 2,
                    ),
                  ),
                ),
                items: Cliente.values
                    .map(
                      (cliente) => DropdownMenuItem(
                        value: cliente,
                        child: Text(cliente.label),
                      ),
                    )
                    .toList(),
                onChanged: vm.setCliente,
                validator: (value) =>
                    value == null ? 'Debes seleccionar Cliente' : null,
              ),
              const SizedBox(height: 10),
              CustomInput(
                title: "Descripción",
                controller: vm.descriptionController,
                textInputType: TextInputType.text,
                validator: (value) {
                  return vm.validation.validate(
                    type: TypeValidation.text,
                    name: "Descripción",
                    value: vm.descriptionController.text,
                    isRequired: false,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
