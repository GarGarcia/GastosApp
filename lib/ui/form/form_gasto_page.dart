import 'package:flutte_scanner_empty/ui/form/widgets/form_body.dart';
import 'package:flutte_scanner_empty/ui/form/widgets/form_gasto_camera_button.dart';
import 'package:flutte_scanner_empty/ui/form/widgets/form_gasto_navbar.dart';
import 'package:flutter/material.dart';

class FormGastosPage extends StatefulWidget {
  const FormGastosPage({super.key});

  @override
  State<FormGastosPage> createState() => _FormGastosPageState();
}

class _FormGastosPageState extends State<FormGastosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FormGastoCameraButton(),
      appBar: FormGastoNavbar(),
      body: FormBody(),
    );
  }
}
