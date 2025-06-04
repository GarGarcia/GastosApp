import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/ui/form/form_gasto_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormGastoFieldFecha extends StatelessWidget {

  final FormGastoViewModel vm;

  const FormGastoFieldFecha({required this.vm ,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Constants.globalColorNeutral70, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text("Fecha: ${DateFormat.yMMMd().format(vm.createdAt)}"),
          ),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              Constants.colourActionPrimary,
            ),
            foregroundColor: WidgetStateProperty.all(
              Constants.colourTextDefault,
            ),
          ),
          onPressed: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              locale: const Locale("es", "ES"),
              initialDate: vm.createdAt,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              vm.setDate(picked);
            }
          },
          child: const Text('Selecciona'),
        ),
      ],
    );
  }
}
