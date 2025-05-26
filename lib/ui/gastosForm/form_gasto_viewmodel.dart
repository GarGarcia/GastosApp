import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutte_scanner_empty/core/validation.dart';
import 'package:flutte_scanner_empty/providers/global_provider.dart';
import 'package:flutte_scanner_empty/data/repository/gasto_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  late GlobalProvider globalProvider;
  final GastoRepository gastoRepository;
  final formKey = GlobalKey<FormState>();
  final Validation validation = Validation();

  Cliente? selectedCliente;
  DateTime createdAt = DateTime.now();
  File? image;
  final picker = ImagePicker();

  late TextEditingController importController;
  late TextEditingController descriptionController;

  FormGastoViewModel({required this.gastoRepository}) {
    importController = TextEditingController();
    descriptionController = TextEditingController();
  }

  void initWithGlobalProvider(GlobalProvider globalProvider) {
    this.globalProvider = globalProvider;
    createdAt = globalProvider.mGasto.mCreatedAt ?? DateTime.now();
    importController.text =
        globalProvider.mGasto.mGastoModelImport?.toString() ?? '';
    descriptionController.text =
        globalProvider.mGasto.mGastoModelDescription ?? '';
    final clientString = globalProvider.mGasto.mGastoModelClient;
    if (clientString != null && clientString.isNotEmpty) {
      try {
        selectedCliente = Cliente.values.firstWhere(
          (c) => c.name.toLowerCase() == clientString.toLowerCase(),
        );
      } catch (_) {
        selectedCliente = null;
      }
    } else {
      selectedCliente = null;
    }
    notifyListeners();
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
    createdAt = DateTime.now();
    notifyListeners();
  }

  Future<String?> uploadImage(File imageFile, String gastoId) async {
    try {
      final storage = Supabase.instance.client.storage;
      final fileName = 'gasto_$gastoId.jpg';
      final filePath = 'gastos/$fileName';

      // Subir imagen al almacenamiento de Supabase
      final response = await storage
          .from('gastos')
          .upload(
            filePath,
            imageFile,
            fileOptions: const FileOptions(upsert: true),
          );

      if (response.isEmpty) return null;

      // Obtener URL pública
      final publicUrl = storage.from('gastos').getPublicUrl(fileName);
      return publicUrl;
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteImage(String? imageUrl) async {
    if (imageUrl == null || imageUrl.isEmpty) return;
    try {
      final storage = Supabase.instance.client.storage;
      final uri = Uri.parse(imageUrl);
      final segments = uri.pathSegments;
      final fileName = segments.isNotEmpty ? segments.last : null;
      if (fileName != null) {
        await storage.from('gastos').remove([fileName]);
      }
    } catch (e) {
      // Manejar error si es necesario
    }
  }

  Future<String?> saveGasto(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      clear();
      return null;
    }
    try {
      final idx = globalProvider.mGasto.mIdx;
      final importValue = double.tryParse(importController.text) ?? 0.0;
      final clientValue = selectedCliente?.name.replaceAll(' ', '') ?? '';
      final descriptionValue = descriptionController.text;
      var imageUrl = globalProvider.mGasto.mImageUrl ?? "";

      if (image != null) {
        // Usa un id temporal si es nuevo, o el idx si existe
        final gastoId = idx ?? DateTime.now().millisecondsSinceEpoch.toString();
        final uploadedUrl = await uploadImage(image!, gastoId);
        if (uploadedUrl != null) {
          imageUrl = uploadedUrl;
        }
      }

      if (idx == null) {
        await gastoRepository.addGasto(
          createdAt,
          importValue,
          clientValue,
          descriptionValue,
          imageUrl,
        );
        clear();
        return 'Gasto creado exitosamente';
      } else {
        await gastoRepository.updateGasto(
          idx,
          createdAt,
          importValue,
          clientValue,
          descriptionValue,
          imageUrl,
        );
        clear();
        return 'Gasto actualizado exitosamente';
      }
    } catch (e) {
      return 'Error al guardar el gasto: $e';
    }
  }

  Future<String?> deleteGasto(BuildContext context) async {
    try {
      final idx = globalProvider.mGasto.mIdx;
      final imageUrl = globalProvider.mGasto.mImageUrl;
      if (idx == null) {
        return 'No fue posible eliminar el gasto';
      } else {
        await deleteImage(imageUrl);
        await gastoRepository.deleteGasto(idx);
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
