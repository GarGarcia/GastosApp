import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/ui/home/home_viewmodel.dart';
import 'package:flutte_scanner_empty/ui/home/widgets/home_gasto_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final view = context.watch<HomeViewModel>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: RefreshIndicator(
        backgroundColor: Constants.colourBackgroundColor,
        color: Constants.colourTextColor,
        strokeWidth: 3,
        displacement: 80,
        onRefresh: () async {
          await view.getGastos();
        },
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(width: 20, height: 20),
                view.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : view.gastosList.isEmpty
                    ? Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                          left: 20,
                          right: 20,
                        ),
                        width: double.infinity,
                        child: Text(
                          "No hay registros para mostrar",
                          style: Constants.typographyBoldL,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : HomeGastoList(),
                const SizedBox(height: 40),
                Text(view.getEmail() ?? "No hay email"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
