// ignore_for_file: use_build_context_synchronously

import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/core/library.dart';
import 'package:flutte_scanner_empty/core/validation.dart';
import 'package:flutte_scanner_empty/ui/form/form_gasto_viewmodel.dart';
import 'package:flutte_scanner_empty/ui/home/home_viewmodel.dart';
import 'package:flutte_scanner_empty/ui/widgets/custom_button.dart';
import 'package:flutte_scanner_empty/ui/widgets/custom_input.dart';
import 'package:flutte_scanner_empty/ui/widgets/navbar_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FormGastosPage extends StatefulWidget {
  const FormGastosPage({super.key});

  @override
  State<FormGastosPage> createState() => _FormGastosPageState();
}

class _FormGastosPageState extends State<FormGastosPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FormGastoViewModel>(
      builder: (context, vm, _) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => _pickOption(context, vm),
            backgroundColor: Constants.colourActionPrimary,
            child: CustomButton(
              color: Colors.transparent,
              width: 50,
              child: Icon(
                Icons.camera_alt,
                color: Constants.colourActionSecondary,
                size: 25,
              ),
            ),
          ),
          appBar: NavbarBack(
            backgroundColor: Constants.colourBackgroundColor,
            backgroundButtonColor: Constants.colourActionPrimary,
            tinte: Tinte.light,
            title: vm.editingGasto.mIdx == null
                ? "Nuevo Gasto"
                : "Editar Gasto",
            showBack: true,
            showMenu: false,
            mListActions: [
              vm.editingGasto.mIdx == null
                  ? const SizedBox()
                  : CustomButton(
                      color: Colors.transparent,
                      width: 50,
                      callback: () {
                        _deleteConfirmation(context, vm);
                      },
                      child: Icon(
                        TablerIcons.trash,
                        color: Constants.colourActionPrimary,
                        size: 25,
                      ),
                    ),
            ],
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: vm.isLoading
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: const Center(child: CircularProgressIndicator()),
                      )
                    : Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              key: vm.formKey,
                              child: Column(
                                children: [
                                  const SizedBox(width: 20, height: 20),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                          border: Border.all(
                                            color:
                                                Constants.globalColorNeutral70,
                                            width: 1,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            "Fecha: ${DateFormat.yMMMd().format(vm.createdAt)}",
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                Constants.colourActionPrimary,
                                              ),
                                          foregroundColor:
                                              WidgetStateProperty.all(
                                                Constants.colourTextDefault,
                                              ),
                                        ),
                                        onPressed: () async {
                                          final picked = await showDatePicker(
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
                                  ),
                                  const SizedBox(height: 10),
                                  CustomInput(
                                    title: "Importe",
                                    controller: vm.importController,
                                    textInputType:
                                        TextInputType.numberWithOptions(
                                          decimal: true,
                                        ),
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
                                          color:
                                              Constants.colourSemanticDanger1,
                                          width: 1,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color:
                                              Constants.colourSemanticDanger1,
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
                                    validator: (value) => value == null
                                        ? 'Debes seleccionar Cliente'
                                        : null,
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
                            ),
                            Center(
                              heightFactor: 1,
                              child:
                                  (vm.editingGasto.mImageUrl == null ||
                                          vm.editingGasto.mImageUrl!.isEmpty) &&
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
                                              vm.editingGasto.mImageUrl!,
                                              loadingBuilder: (context, child, loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child: CircularProgressIndicator(
                                                    value:
                                                        loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              (loadingProgress
                                                                      .expectedTotalBytes ??
                                                                  1)
                                                        : null,
                                                  ),
                                                );
                                              },
                                            ),
                                    ),
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                              color: Constants.colourActionPrimary,
                              callback: () async {
                                final result = await vm.saveGasto(context);
                                if (!mounted) return;
                                if (result != null) {
                                  customShowToast(context, result);
                                  context.read<HomeViewModel>().getGastos();
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(
                                'Guardar',
                                style: Constants.typographyButtonM,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _pickOption(BuildContext context, FormGastoViewModel vm) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Escanear Gastos", style: Constants.typographyBlackBodyL),
          content: SingleChildScrollView(
            child: Text(
              'Elije una opción para escanear el Gastos',
              style: Constants.typographyBlackBodyM,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                vm.pickImage("galeria");
                Navigator.of(context).pop();
              },
              child: Text("Galeria", style: Constants.typographyBoldM),
            ),
            TextButton(
              onPressed: () {
                vm.pickImage("camara");
                Navigator.of(context).pop();
              },
              child: Text("Camara", style: Constants.typographyBoldM),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close", style: Constants.typographyDangerBoldM),
            ),
          ],
        );
      },
    );
  }

  void _deleteConfirmation(BuildContext context, FormGastoViewModel vm) {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      backgroundColor: Constants.colourBackgroundColor,
      builder: (BuildContext context) {
        return Container(
          color: Constants.colourBackgroundColor,
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Eliminar gasto',
                  style: Constants.typographyHeadingM,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: Text(
                  '¿Quieres eliminar el gasto?',
                  style: Constants.typographyBodyM,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: CustomButton(
                      width: double.infinity,
                      color: Constants.colourActionSecondary,
                      callback: () => Navigator.of(context).pop(),
                      child: Text(
                        "Atrás",
                        style: Constants.typographyButtonMSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    flex: 1,
                    child: CustomButton(
                      width: double.infinity,
                      color: Constants.colourActionPrimary,
                      callback: () async {
                        final result = await vm.deleteGasto(context);
                        if (!mounted) {
                          return;
                        }
                        if (result != null) {
                          customShowToast(context, result);
                          context.read<HomeViewModel>().getGastos();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Eliminar",
                        style: Constants.typographyButtonM,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
