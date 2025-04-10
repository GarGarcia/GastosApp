import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/core/library.dart';
import 'package:flutte_scanner_empty/core/validation.dart';
import 'package:flutte_scanner_empty/ui/widgets/custom_button.dart';
import 'package:flutte_scanner_empty/ui/widgets/custom_input.dart';
import 'package:flutte_scanner_empty/ui/widgets/navbar_back.dart';
import 'package:flutte_scanner_empty/providers/global_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FormCountryPage extends StatefulWidget {
  const FormCountryPage({super.key});

  @override
  State<FormCountryPage> createState() => _FormCountryPageState();
}

class _FormCountryPageState extends State<FormCountryPage> {
  final supabase = Supabase.instance.client;

  final _formKey = GlobalKey<FormState>();

  Validation mValidation = Validation();

  late TextEditingController mTicketNameController;
  late TextEditingController mTicketCodeController;
  late TextEditingController mTicketCodeLetterController;

  @override
  void initState() {
    super.initState();

    mTicketNameController = TextEditingController();
    mTicketCodeController = TextEditingController();
    mTicketCodeLetterController = TextEditingController();

    mTicketNameController.text =
        Provider.of<GlobalProvider>(
          context,
          listen: false,
        ).mTicket.mTicketModelName ??
        '';
    mTicketCodeController.text =
        Provider.of<GlobalProvider>(
          context,
          listen: false,
        ).mTicket.mTicketModelCode ??
        '';
    mTicketCodeLetterController.text =
        Provider.of<GlobalProvider>(
          context,
          listen: false,
        ).mTicket.mTicketModelCodeLetter ??
        '';
  }

  @override
  void dispose() {
    mTicketNameController.dispose();
    mTicketCodeController.dispose();
    mTicketCodeLetterController.dispose();
    super.dispose();
  }

  _formValidation() async {
    String mMessage = "";
    if (!_formKey.currentState!.validate()) {
      _clear();
    } else {
      if (mTicketNameController.text.isEmpty) {
        customShowToast(globalContext!, 'Por favor, complete todos los campos');
        return;
      }

      try {
        globalContext = context;

        if (Provider.of<GlobalProvider>(context, listen: false).mTicket.mIdx ==
            null) {
          progressDialogShow(globalContext!);
          await supabase.from('countries').insert({
            'country_name': mTicketNameController.text,
            'country_code': mTicketCodeController.text,
            'country_code_letter': mTicketCodeLetterController.text,
          });
          dialogDismiss();

          customShowToast(globalContext!, 'País creado exitosamente');
        } else {
          progressDialogShow(globalContext!);
          await supabase
              .from('countries')
              .update({
                'country_name': mTicketNameController.text,
                'country_code': mTicketCodeController.text,
                'country_code_letter': mTicketCodeLetterController.text,
              })
              .eq(
                'idx',
                Provider.of<GlobalProvider>(
                  context,
                  listen: false,
                ).mTicket.mIdx!,
              );
          dialogDismiss();

          customShowToast(globalContext!, 'País actualizado exitosamente');
        }

        Navigator.of(globalContext!).pop();

        mTicketNameController.clear();
        mTicketCodeController.clear();
        mTicketCodeLetterController.clear();
      } catch (e) {
        globalContext = context;
        ScaffoldMessenger.of(
          globalContext!,
        ).showSnackBar(SnackBar(content: Text('Error al guardar el país: $e')));
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
                  'Eliminar ticket',
                  style: Constants.typographyHeadingM,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: Text(
                  '¿Quieres eliminar el ticket? ',
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
                        deleteCountry();
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

  deleteCountry() async {
    try {
      if (Provider.of<GlobalProvider>(context, listen: false).mTicket.mIdx ==
          null) {
        // alert
        customShowToast(globalContext!, 'No fue posible eliminar el ticket');
      } else {
        // update country into the 'countries' table
        progressDialogShow(globalContext!);
        await supabase
            .from('countries')
            .delete()
            .eq(
              'idx',
              Provider.of<GlobalProvider>(
                context,
                listen: false,
              ).mTicket.mIdx!,
            );
        //Timer(Duration(seconds: 3), () {});
        dialogDismiss();

        customShowToast(globalContext!, 'Ticket eliminado exitosamente');
      }
    } catch (e) {
      // Show error message if the insertion fails
      customShowToast(globalContext!, 'Error al guardar el ticket: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavbarBack(
        backgroundColor: Constants.colourBackgroundColor,
        backgroundButtonColor: Constants.colourActionPrimary,
        tinte: Tinte.light,
        title:
            Provider.of<GlobalProvider>(context, listen: false).mTicket.mIdx ==
                    null
                ? "Nuevo Ticket"
                : "Editar Ticket",
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
                        ).mTicket.mTicketModelName!,
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
                          CustomInput(
                            title: "Nombre del ticket",
                            controller: mTicketNameController,
                            textInputType: TextInputType.text,
                            hint: 'ej: España',
                            validator: (value) {
                              return mValidation.validate(
                                type: TypeValidation.text,
                                name: "Nombre del ticket",
                                value: mTicketNameController.text,
                                isRequired: true,
                                min: 3,
                                max: 80,
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          CustomInput(
                            title: "Codigo del ticket",
                            controller: mTicketCodeController,
                            textInputType: TextInputType.text,
                            hint: 'ej: 34',
                            validator: (value) {
                              return mValidation.validate(
                                type: TypeValidation.numbers,
                                name: "Código del ticket",
                                value: mTicketCodeController.text,
                                isRequired: false,
                                min: 1,
                                max: 3,
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          CustomInput(
                            title: "Codigo de letras del ticket",
                            controller: mTicketCodeLetterController,
                            textInputType: TextInputType.text,
                            hint: 'ej: ES',
                            validator: (value) {
                              return mValidation.validate(
                                type: TypeValidation.text,
                                name: "Código de letras del ticket",
                                value: mTicketCodeLetterController.text,
                                isRequired: true,
                                min: 2,
                                max: 2,
                              );
                            },
                          ),
                        ],
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
}
