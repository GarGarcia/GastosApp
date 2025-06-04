import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/ui/form/form_gasto_viewmodel.dart';
import 'package:flutter/material.dart';

class FormGastoFieldDropdownCliente extends StatelessWidget {
  final FormGastoViewModel vm;

  const FormGastoFieldDropdownCliente({required this.vm, super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Cliente>(
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
            (cliente) =>
                DropdownMenuItem(value: cliente, child: Text(cliente.label)),
          )
          .toList(),
      onChanged: vm.setCliente,
      validator: (value) => value == null ? 'Debes seleccionar Cliente' : null,
    );
  }
}
