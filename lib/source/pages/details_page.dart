import 'package:flutte_scanner_empty/source/custom/constants.dart';
import 'package:flutte_scanner_empty/source/custom/library.dart';
import 'package:flutte_scanner_empty/source/custom/validation.dart';
import 'package:flutte_scanner_empty/source/providers/global_provider.dart';
import 'package:flutte_scanner_empty/source/widgets/custom_button.dart';
import 'package:flutte_scanner_empty/source/widgets/custom_input.dart';
import 'package:flutte_scanner_empty/source/widgets/navbar_back.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final _formKey = GlobalKey<FormState>();

  Validation mValidationCountryName = Validation();
  Validation mValidationCountryCode = Validation();

  late TextEditingController mCountryNameController;
  late TextEditingController mCountryCodeController;

  @override
  void initState() {
    super.initState();

    mCountryNameController = TextEditingController();
    mCountryCodeController = TextEditingController();

    mCountryNameController.text = Provider.of<GlobalProvider>(context, listen: false).mCountry.mCountryName ?? '';
    mCountryCodeController.text = Provider.of<GlobalProvider>(context, listen: false, ).mCountry.mCountryCode ?? '';
  }

  @override
  void dispose() {
    mCountryNameController.dispose();
    mCountryCodeController.dispose();
    super.dispose();
  }

  _formValidation() async {
    String mMessage = "";
    if(!_formKey.currentState!.validate()){
      _clear();
    } else{
      if(mCountryNameController.text.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, complete todos los campos')), 
        );
        return;
      }

      final supabase = Supabase.instance.client;

      try {
        await supabase.from('countries').update({
          'country_name': mCountryNameController.text,
          'country_code': mCountryCodeController.text,
        }).eq('idx', Provider.of<GlobalProvider>(context, listen: false).mCountry.mIdx!);

        globalContext = context;
        ScaffoldMessenger.of(globalContext!).showSnackBar(
          const SnackBar(
            content: Text('País guardado exitosamente'),
            ),
        );

        Navigator.of(globalContext!).pop();

        mCountryNameController.clear();
        mCountryCodeController.clear();
      } catch (e){
        globalContext = context;
        ScaffoldMessenger.of(globalContext!).showSnackBar(
          SnackBar(content: Text('Error al guardar el país: $e')),
        );
      }

    }

    if(mMessage.isNotEmpty){
      globalContext = context;
      customShowToast(globalContext!, mMessage);
      _clear();
    }
  }

  _clear(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavbarBack(
        backgroundColor: Constants.colourBackgroundColor,
        backgroundButtonColor: Constants.colourActionPrimary,
        tinte: Tinte.light,
        title: "Editar país",
        showBack: true,
        showMenu: false,
        mListActions: [],
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
                            title: "Nombre del país",
                            controller: mCountryNameController,
                            textInputType: TextInputType.text,
                            validator: (value) {
                              return mValidationCountryName.validate(
                                type: TypeValidation.text,
                                name: "Nombre del país",
                                value: mCountryNameController.text,
                                isRequired: true,
                                min: 3,
                                max: 80,
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          CustomInput(
                            title: "Codigo del país",
                            controller: mCountryCodeController,
                            textInputType: TextInputType.text,
                            validator: (value) {
                              return mValidationCountryCode.validate(
                                type: TypeValidation.numbers,
                                name: "Código del país",
                                value: mCountryCodeController.text,
                                isRequired: false,
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
