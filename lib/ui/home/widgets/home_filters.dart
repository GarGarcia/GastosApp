import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/ui/form/form_gasto_viewmodel.dart';
import 'package:flutte_scanner_empty/ui/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final view = context.read<HomeViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Filtro por fecha
          Expanded(
            child: InkWell(
              onTap: () async {
                final picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime.now().subtract(Duration(days: 365)),
                  lastDate: DateTime.now(),
                  initialDateRange: view.selectedRange,
                  locale: const Locale("es", "ES"),
                  initialEntryMode: DatePickerEntryMode.input,
                );
                if (picked != null) {
                  view.setDateRange(picked);
                  await view.getGastos();
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Constants.globalColorNeutral30),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  view.selectedRange == null
                      ? "Filtrar por fecha"
                      : "${DateFormat.yMMMd().format(view.selectedRange!.start)} - ${DateFormat.yMMMd().format(view.selectedRange!.end)}",
                  style: Constants.typographyBlackBodyM,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          // Filtro por cliente
          Expanded(
            child: DropdownButton<String>(
              value: view.selectedCliente,
              hint: Text("Cliente"),
              isExpanded: true,
              items: [
                DropdownMenuItem(value: null, child: Text("Todos")),
                ...Cliente.values.map(
                  (c) => DropdownMenuItem(value: c.name, child: Text(c.label)),
                ),
              ],
              onChanged: (value) {
                view.setCliente(value);
                view.getGastos();
              },
            ),
          ),
        ],
      ),
    );
  }
}
