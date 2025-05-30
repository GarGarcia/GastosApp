import 'package:flutte_scanner_empty/ui/home/home_viewmodel.dart';
import 'package:flutte_scanner_empty/ui/home/widgets/home_filters.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'gastos_list.dart';
import 'user_email.dart';

class HomeBody extends StatelessWidget {
  const HomeBody();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<HomeViewModel>().getGastos(),
      child: ListView(
        children: const [
          SizedBox(height: 10),
          HomeFilters(),
          SizedBox(height: 10),
          GastosList(),
          SizedBox(height: 40),
          UserEmail(),
        ],
      ),
    );
  }
}
