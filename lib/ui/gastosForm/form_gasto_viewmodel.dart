import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutte_scanner_empty/core/validation.dart';
import 'package:flutte_scanner_empty/providers/global_provider.dart';
import 'package:provider/provider.dart';

enum Cliente { mercadona, lidl, ikea, mediamarkt, amazon }

extension ClienteExtension on Cliente {
  String get label {
    switch (this) {
      case Cliente.mercadona:
        return 'MERCADONA';
      case Cliente.lidl:
        return 'LIDL';
      case Cliente.ikea:
        return 'IKEA';
      case Cliente.mediamarkt:
        return 'MEDIA MARKT';
      case Cliente.amazon:
        return 'AMAZON';
    }
  }
}

class FormGastoViewModel extends ChangeNotifier {
  final GlobalProvider globalProvider;
  final supabase = Supabase.instance.client;
  final formKey = GlobalKey<FormState>();
  final Validation validation = Validation();

  Cliente? selectedCliente;
  DateTime createdAt = DateTime.now();
  File? image;
  final picker = ImagePicker();

  late TextEditingController importController;
  late TextEditingController descriptionController;

  FormGastoViewModel(this.globalProvider) {
    importController = TextEditingController();
    descriptionController = TextEditingController();

    createdAt = globalProvider.mGasto.mCreatedAt ?? DateTime.now();
    importController.text =
        globalProvider.mGasto.mGastoModelImport?.toString() ?? '';
    descriptionController.text =
        globalProvider.mGasto.mGastoModelDescription ?? '';

    final clientString = globalProvider.mGasto.mGastoModelClient;
    if (clientString != null) {
      try {
        selectedCliente = Cliente.values.firstWhere(
          (c) => c.name.toLowerCase() == clientString.toLowerCase(),
        );
      } catch (_) {
        selectedCliente = null;
      }
    }
  }

  void setCliente(Cliente? cliente) {
    selectedCliente = cliente;
    notifyListeners();
  }

  void setDate(DateTime date) {
    createdAt = date;
    notifyListeners();
  }

  Future<void> pickImage(String option) async {
    XFile? pickedFile;
    if (option == "galeria") {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    } else if (option == "camara") {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    }
    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    }
  }

  void clear() {
    importController.clear();
    descriptionController.clear();
    selectedCliente = null;
    image = null;
    notifyListeners();
  }

  Future<String?> saveGasto(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      clear();
      return null;
    }
    try {
      final globalProvider = Provider.of<GlobalProvider>(
        context,
        listen: false,
      );
      if (globalProvider.mGasto.mIdx == null) {
        await supabase.from('gastos').insert({
          'created_at': "${createdAt.year}-${createdAt.month}-${createdAt.day}",
          'import': double.tryParse(importController.text),
          'client': selectedCliente?.name.replaceAll(' ', '') ?? '',
          'description': descriptionController.text,
        });
        clear();
        return 'Gasto creado exitosamente';
      } else {
        await supabase
            .from('gastos')
            .update({
              'created_at':
                  "${createdAt.year}-${createdAt.month}-${createdAt.day}",
              'import': double.tryParse(importController.text),
              'client': selectedCliente?.name.replaceAll(' ', '') ?? '',
              'description': descriptionController.text,
            })
            .eq('idx', globalProvider.mGasto.mIdx!);
        clear();
        return 'Gasto actualizado exitosamente';
      }
    } catch (e) {
      return 'Error al guardar el gasto: $e';
    }
  }

  Future<String?> deleteGasto(BuildContext context) async {
    try {
      final globalProvider = Provider.of<GlobalProvider>(
        context,
        listen: false,
      );
      if (globalProvider.mGasto.mIdx == null) {
        return 'No fue posible eliminar el gasto';
      } else {
        await supabase
            .from('gastos')
            .delete()
            .eq('idx', globalProvider.mGasto.mIdx!);
        clear();
        return 'Gasto eliminado exitosamente';
      }
    } catch (e) {
      return 'Error al eliminar el gasto: $e';
    }
  }

  @override
  void dispose() {
    importController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
