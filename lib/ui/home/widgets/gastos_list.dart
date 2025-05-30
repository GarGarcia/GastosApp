import 'package:flutte_scanner_empty/ui/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/gasto_model.dart';
import 'gastos_item.dart';

class GastosList extends StatelessWidget {
  const GastosList({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<HomeViewModel, List<GastoModel>>(
      selector: (_, vm) => vm.gastosList,
      builder: (context, gastosList, _) {
        final isLoading = context.select<HomeViewModel, bool>((vm) => vm.isLoading);

        if (isLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (gastosList.isEmpty) {
          return const Center(child: Text("No hay registros para mostrar"));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: gastosList.length,
          itemBuilder: (context, index) => GastosItem(gasto: gastosList[index]),
        );
      },
    );
  }
}
