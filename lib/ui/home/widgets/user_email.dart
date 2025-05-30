import 'package:flutte_scanner_empty/ui/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserEmail extends StatelessWidget {
  const UserEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(context.read<HomeViewModel>().getEmail() ?? "No hay email"),
    );
  }
}
