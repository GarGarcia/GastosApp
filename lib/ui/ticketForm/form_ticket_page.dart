import 'dart:io';

import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/core/library.dart';
import 'package:flutte_scanner_empty/core/validation.dart';
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

class _FormTicketPageState extends State<FormTicketPage> {
  final supabase = Supabase.instance.client;

  final _formKey = GlobalKey<FormState>();

  Validation _validation = Validation();

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

    mTicketClientController.text =
        Provider.of<GlobalProvider>(
          context,
          listen: false,
        ).mTicket.mTicketModelClient ??
        '';
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

  pickOption() {
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
                Navigator.pop(context);
              },
              child: Text("Galeria", style: Constants.typographyBoldM),
            ),
            TextButton(
              onPressed: () {
                pickImage("camara");
                Navigator.pop(context);
              },
              child: Text("Camara", style: Constants.typographyBoldM),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
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
      initialDate: createdAt,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != createdAt) {
      setState(() {
        createdAt = picked;
        // Provider.of<GlobalProvider>(context).mTicket.mCreatedAt = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pickOption();
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
            Provider.of<GlobalProvider>(context, listen: false).mTicket.mIdx ==
                    null
                ? "Nuevo Gasto"
                : "Editar Gasto",
        showBack: true,
        showMenu: false,
        mListActions: [
          Provider.of<GlobalProvider>(context, listen: false).mTicket.mIdx ==
                  null
              ? const SizedBox()
              : CustomButton(
                color: Colors.transparent,
                width: 50,
                callback: () async {
                  globalContext = context;
                  deleteConfirmation(
                    context: globalContext!,
                    mTicketName:
                        Provider.of<GlobalProvider>(
                          context,
                          listen: false,
                        ).mTicket.mTicketModelClient!,
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
          onRefresh: () async {
            if (mounted) {
              globalContext = context;
            }
          },
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
                          CustomInput(
                            title: "Cliente",
                            controller: mTicketClientController,
                            textInputType: TextInputType.text,
                            validator: (value) {
                              return _validation.validate(
                                type: TypeValidation.text,
                                name: "Cliente",
                                value: mTicketClientController.text,
                                isRequired: true,
                              );
                            },
                          ),
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
                        _formValidation();
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

  _formValidation() async {
    String mMessage = "";
    if (!_formKey.currentState!.validate()) {
      _clear();
    } else {
      try {
        globalContext = context;

        if (Provider.of<GlobalProvider>(context, listen: false).mTicket.mIdx ==
            null) {
          progressDialogShow(globalContext!);
          await supabase.from('gastos').insert({
            'created_at':
                "${createdAt.year}-${createdAt.month}-${createdAt.day}",
            'import': double.tryParse(mTicketImportController.text),
            'client': mTicketClientController.text,
            'description': mTicketDescriptionController.text,
          });
          dialogDismiss();

          customShowToast(globalContext!, 'Gasto creado exitosamente');
        } else {
          progressDialogShow(globalContext!);
          await supabase
              .from('gastos')
              .update({
                'created_at':
                    "${createdAt.year}-${createdAt.month}-${createdAt.day}",
                'import': double.tryParse(mTicketImportController.text),
                'client': mTicketClientController.text,
                'description': mTicketDescriptionController.text,
              })
              .eq(
                'idx',
                Provider.of<GlobalProvider>(
                  context,
                  listen: false,
                ).mTicket.mIdx!,
              );
          dialogDismiss();

          customShowToast(globalContext!, 'Gasto actualizado exitosamente');
        }

        Navigator.of(globalContext!).pop();

        mTicketImportController.clear();
        mTicketClientController.clear();
        mTicketDescriptionController.clear();
      } catch (e) {
        globalContext = context;
        ScaffoldMessenger.of(globalContext!).showSnackBar(
          SnackBar(content: Text('Error al guardar el gasto: $e')),
        );
      }
    }

    if (mMessage.isNotEmpty) {
      globalContext = context;
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
                      callback: () => Navigator.pop(context),
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
                        deleteGasto();
                        Navigator.pop(globalContext!);
                        Navigator.pop(globalContext!);
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

  deleteGasto() async {
    try {
      if (Provider.of<GlobalProvider>(context, listen: false).mTicket.mIdx ==
          null) {
        // alert
        customShowToast(globalContext!, 'No fue posible eliminar el gasto');
      } else {
        // update country into the 'countries' table
        progressDialogShow(globalContext!);
        await supabase
            .from('gastos')
            .delete()
            .eq(
              'idx',
              Provider.of<GlobalProvider>(context, listen: false).mTicket.mIdx!,
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
