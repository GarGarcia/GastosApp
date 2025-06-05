import 'package:flutte_scanner_empty/core/validation.dart';
import 'package:flutte_scanner_empty/ui/form/form_gasto_viewmodel.dart';
import 'package:flutte_scanner_empty/ui/form/widgets/form_gasto_field_dropdown_cliente.dart';
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
                textInputType: TextInputType.number,
                validator: (value) {
                  return vm.validation.validate(
                    type: TypeValidation.numbers,
                    name: "Importe",
                    value: vm.importController.text,
                    isRequired: true,
                    max: 15,
                  );
                },
              ),
              const SizedBox(height: 10),
              FormGastoFieldDropdownCliente(vm: vm),
              const SizedBox(height: 10),
              CustomInput(
                title: "Descripción",
                controller: vm.descriptionController,
                textInputType: TextInputType.text,
                validator: (value) {
                  return vm.validation.validate(
                    type: TypeValidation.txtnum,
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
