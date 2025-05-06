import 'dart:io';

import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/core/library.dart';
import 'package:flutte_scanner_empty/core/validation.dart';
import 'package:flutte_scanner_empty/ui/home/home_viewmodel.dart';
import 'package:flutte_scanner_empty/ui/widgets/custom_button.dart';
import 'package:flutte_scanner_empty/ui/widgets/custom_input.dart';
import 'package:flutte_scanner_empty/ui/widgets/navbar_back.dart';
import 'package:flutte_scanner_empty/providers/global_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FormTicketPage extends StatefulWidget {
  const FormTicketPage({super.key});

  @override
  State<FormTicketPage> createState() => _FormTicketPageState();
}

enum Cliente { absara, aceitesmestral, aeroxadvanced, agrosana, alinatur }

extension ClienteExtension on Cliente {
  String get label {
    switch (this) {
      case Cliente.absara:
        return 'ABSARA';
      case Cliente.aceitesmestral:
        return 'ACEITES MESTRAL';
      case Cliente.aeroxadvanced:
        return 'AEROX ADVANCED';
      case Cliente.agrosana:
        return 'AGROSANA';
      case Cliente.alinatur:
        return 'ALINATUR';
    }
  }
}

class _FormTicketPageState extends State<FormTicketPage> {
  final supabase = Supabase.instance.client;

  final _formKey = GlobalKey<FormState>();

  Validation _validation = Validation();

  Cliente? _selectedCliente;

  DateTime createdAt = DateTime.now();
  late TextEditingController mTicketImportController;
  late TextEditingController mTicketClientController;
  late TextEditingController mTicketDescriptionController;

  @override
  void initState() {
    super.initState();
    mTicketImportController = TextEditingController();
    mTicketClientController = TextEditingController();
    mTicketDescriptionController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    createdAt =
        Provider.of<GlobalProvider>(context).mTicket.mCreatedAt ??
        DateTime.now();

    mTicketImportController.text =
        Provider.of<GlobalProvider>(
                  context,
                  listen: false,
                ).mTicket.mTicketModelImport !=
                null
            ? Provider.of<GlobalProvider>(
              context,
              listen: false,
            ).mTicket.mTicketModelImport.toString()
            : '';

    final clientString =
        context.read<GlobalProvider>().mTicket.mTicketModelClient;

    if (clientString != null) {
      try {
        _selectedCliente = Cliente.values.firstWhere(
          (c) => c.name.toLowerCase() == clientString.toLowerCase(),
        );
      } catch (e) {
        _selectedCliente = null;
      }
    }

    // mTicketClientController.text =
    //     Provider.of<GlobalProvider>(
    //       context,
    //       listen: false,
    //     ).mTicket.mTicketModelClient ??
    //     '';
    mTicketDescriptionController.text =
        Provider.of<GlobalProvider>(
          context,
          listen: false,
        ).mTicket.mTicketModelDescription ??
        '';
  }

  @override
  void dispose() {
    mTicketImportController.dispose();
    mTicketClientController.dispose();
    mTicketDescriptionController.dispose();
    super.dispose();
  }

  File? _image;

  final _picker = ImagePicker();

  pickImage(option) async {
    late XFile? pickedFile;

    switch (option) {
      case "galeria":
        pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      case "camara":
        pickedFile = await _picker.pickImage(source: ImageSource.camera);
    }

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {});
    }
  }

  pickOption(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Escanear ticket", style: Constants.typographyBlackBodyL),
          content: SingleChildScrollView(
            child: Text(
              'Elije una opción para escanear el ticket',
              style: Constants.typographyBlackBodyM,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                pickImage("galeria");
                Navigator.of(context).pop();
              },
              child: Text("Galeria", style: Constants.typographyBoldM),
            ),
            TextButton(
              onPressed: () {
                pickImage("camara");
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: const Locale("es", "ES"),
      initialDate: createdAt,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != createdAt) {
      createdAt = picked;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pickOption(context);
        },
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
        title:
            context.read<GlobalProvider>().mTicket.mIdx ==
                    null
                ? "Nuevo Gasto"
                : "Editar Gasto",
        showBack: true,
        showMenu: false,
        mListActions: [
          context.read<GlobalProvider>().mTicket.mIdx ==
                  null
              ? const SizedBox()
              : CustomButton(
                color: Colors.transparent,
                width: 50,
                callback: () async {
                  deleteConfirmation(
                    context: context,
                    mTicketName:
                        context
                            .read<GlobalProvider>()
                            .mTicket
                            .mTicketModelClient!,
                  );
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
        child: RefreshIndicator(
          backgroundColor: Constants.colourBackgroundColor,
          color: Constants.colourTextColor,
          strokeWidth: 3,
          displacement: 80,
          onRefresh: () async {},
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(width: 20, height: 20),
                          Row(
                            spacing: 22,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Constants.globalColorNeutral70,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    "Fecha: ${DateFormat.yMMMd().format(createdAt)}",
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                    Constants.colourActionPrimary,
                                  ),
                                  foregroundColor: WidgetStateProperty.all(
                                    Constants.colourTextDefault,
                                  ),
                                ),
                                onPressed: () => _selectDate(context),
                                child: const Text('Selecciona'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          CustomInput(
                            title: "Importe",
                            controller: mTicketImportController,
                            textInputType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            validator: (value) {
                              return _validation.validate(
                                type: TypeValidation.dec,
                                name: "Importe",
                                value: mTicketImportController.text,
                                isRequired: true,
                                max: 15,
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<Cliente>(
                            menuMaxHeight: 110,
                            value: _selectedCliente,
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
                            items:
                                Cliente.values.map((cliente) {
                                  return DropdownMenuItem(
                                    value: cliente,
                                    child: Text(cliente.label),
                                  );
                                }).toList(),
                            onChanged: (Cliente? value) {
                              _selectedCliente = value;
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Selecciona un cliente';
                              }
                              return null;
                            },
                          ),
                          // CustomInput(
                          //   title: "Cliente",
                          //   controller: mTicketClientController,
                          //   textInputType: TextInputType.text,
                          //   validator: (value) {
                          //     return _validation.validate(
                          //       type: TypeValidation.text,
                          //       name: "Cliente",
                          //       value: mTicketClientController.text,
                          //       isRequired: true,
                          //     );
                          //   },
                          // ),
                          const SizedBox(height: 10),
                          CustomInput(
                            title: "Descripción",
                            controller: mTicketDescriptionController,
                            textInputType: TextInputType.text,
                            validator: (value) {
                              return _validation.validate(
                                type: TypeValidation.text,
                                name: "Descripción",
                                value: mTicketDescriptionController.text,
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
                          _image == null
                              ? Text(
                                "Ticket no escaneado",
                                style: Constants.typographyBlackBodyL,
                              )
                              : SizedBox(
                                height: 300,
                                width: double.infinity,
                                child: Image.file(_image!),
                              ),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      color: Constants.colourActionPrimary,
                      callback: () async {
                        _formValidation(context);
                        context.read<HomeViewModel>().getGastos();
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
      ),
    );
  }

  Future<void> _formValidation(BuildContext context) async {
    globalContext = context;
    String mMessage = "";
    if (!_formKey.currentState!.validate()) {
      _clear();
    } else {
      try {
        if (context.read<GlobalProvider>().mTicket.mIdx ==
            null) {
          progressDialogShow(context);

          await supabase.from('gastos').insert({
            'created_at':
                "${createdAt.year}-${createdAt.month}-${createdAt.day}",
            'import': double.tryParse(mTicketImportController.text),
            'client': _selectedCliente?.name.replaceAll(' ', '') ?? '',
            'description': mTicketDescriptionController.text,
          });
          dialogDismiss();
          
          customShowToast(globalContext!, 'Gasto creado exitosamente');
        } else {
          progressDialogShow(context);
          await supabase
              .from('gastos')
              .update({
                'created_at':
                    "${createdAt.year}-${createdAt.month}-${createdAt.day}",
                'import': double.tryParse(mTicketImportController.text),
                'client': _selectedCliente?.name.replaceAll(' ', '') ?? '',
                'description': mTicketDescriptionController.text,
              })
              .eq(
                'idx',
                context.read<GlobalProvider>().mTicket.mIdx!,
              );
          dialogDismiss();

          customShowToast(globalContext!, 'Gasto actualizado exitosamente');
        }

        Navigator.pop(globalContext!, true);
        mTicketImportController.clear();
        mTicketClientController.clear();
        mTicketDescriptionController.clear();
      } catch (e) {
        ScaffoldMessenger.of(globalContext!).showSnackBar(
          SnackBar(content: Text('Error al guardar el gasto: $e')),
        );
      }
    }

    if (mMessage.isNotEmpty) {
      customShowToast(globalContext!, mMessage);
      _clear();
    }
  }

  _clear() {
    setState(() {});
  }

  deleteConfirmation({
    required BuildContext context,
    required String mTicketName,
  }) {
    return showModalBottomSheet(
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
                      callback: () {
                        deleteGasto(context);
                        Navigator.pop(context);
                        Navigator.pop(context, true);
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

  deleteGasto(BuildContext context) async {
    globalContext = context;
    try {
      if (context.read<GlobalProvider>().mTicket.mIdx ==
          null) {
        customShowToast(globalContext!, 'No fue posible eliminar el gasto');
      } else {
        progressDialogShow(context);
        await supabase
            .from('gastos')
            .delete()
            .eq(
              'idx',
              context.read<GlobalProvider>().mTicket.mIdx!,
            );
        //Timer(Duration(seconds: 3), () {});
        dialogDismiss();

        customShowToast(globalContext!, 'Gasto eliminado exitosamente');
      }
    } catch (e) {
      // Show error message if the insertion fails
      customShowToast(globalContext!, 'Error al guardar el gasto: $e');
    }
  }
}
