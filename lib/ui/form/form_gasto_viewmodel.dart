import 'dart:io';
import 'package:flutte_scanner_empty/data/models/gasto_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutte_scanner_empty/core/validation.dart';
import 'package:flutte_scanner_empty/data/repository/gasto_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

enum Cliente { mercadona, lidl, ikea, mediamarkt, amazon, nvidia, nike, adidas, microsoft, ibm, iberdrola }

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
      case Cliente.nvidia:
        return 'NVIDIA';
      case Cliente.nike:
        return 'NIKE';
      case Cliente.adidas:
        return 'ADIDAS';
      case Cliente.microsoft:
        return 'MICROSOFT';
      case Cliente.ibm:
        return 'IBM';
      case Cliente.iberdrola:
        return 'IBERDROLA';        
    }
  }
}

class FormGastoViewModel extends ChangeNotifier {
  final StorageFileApi storage;
  final GastoRepository gastoRepository;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Validation validation = Validation();

  bool isLoading = false;

  GastoModel _editingGasto = GastoModel();
  Cliente? selectedCliente;
  DateTime createdAt = DateTime.now();
  File? image;
  final ImagePicker picker = ImagePicker();
  final Uuid uuid = Uuid();

  late TextEditingController importController;
  late TextEditingController descriptionController;

  FormGastoViewModel({required this.gastoRepository, required this.storage}) {
    importController = TextEditingController();
    descriptionController = TextEditingController();
  }

  void initWithGlobalProvider(GastoModel gasto) {
    _editingGasto = gasto;
    createdAt = gasto.gastoModelCreatedAt ?? DateTime.now();
    importController.text = gasto.gastoModelImport?.toString() ?? '';
    descriptionController.text = gasto.gastoModelDescription ?? '';
    final String? clientString = gasto.gastoModelClient;
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
  }

  GastoModel get editingGasto => _editingGasto;

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

  Future<String?> uploadImage(File imageFile, String imageId) async {
    try {
      final String fileName = 'gasto_$imageId.jpg';

      // Subir imagen al almacenamiento de Supabase
      final String response = await storage.upload(
            fileName,
            imageFile,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );

      if (response.isEmpty) return null;

      // Obtener URL pública
      final String publicUrl = storage.getPublicUrl(fileName);

      return publicUrl;
    } catch (e) {
      return 'Error al subir la imagen: $e';
    }
  }

  Future<String?> deleteImage(String? imageUrl) async {
    if (imageUrl == null || imageUrl.isEmpty) {
      return "No se proporcionó una URL de imagen válida";
    }
    try {
      final Uri uri = Uri.parse(imageUrl);
      final List<String> segments = uri.pathSegments;
      final String? fileName = segments.isNotEmpty ? segments.last : null;
      if (fileName != null) {
        await storage.remove([fileName]);
      }
      return "";
    } catch (e) {
      return 'Error al eliminar la imagen: $e';
    }
  }

  Future<String?> saveGasto(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      clear();
      return null;
    }
    isLoading = true;
    notifyListeners();
    try {
      final String? idx = _editingGasto.idx;
      final double importValue = double.parse(importController.text);
      final String clientValue = selectedCliente?.name.replaceAll(' ', '') ?? '';
      final String descriptionValue = descriptionController.text;
      String imageUrl = _editingGasto.gastoModelImageUrl ?? "";
      final String imageId = _editingGasto.gastoModelImageId ?? uuid.v4();
      _editingGasto.gastoModelImageId = imageId;

      if (image != null) {
        // Usa un id temporal si es nuevo, o el idx si existe
        final String gastoId = idx ?? DateTime.now().millisecondsSinceEpoch.toString();
        final String? uploadedUrl = await uploadImage(image!, gastoId);
        if (uploadedUrl != null) {
          imageUrl = uploadedUrl;
        } else {
          return 'Error al subir la imagen';
        }
      }

      if (idx == null) {
        await gastoRepository.addGasto(
          createdAt,
          importValue,
          clientValue,
          descriptionValue,
          imageUrl,
          imageId,
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
          imageId,
        );
        clear();
        return 'Gasto actualizado exitosamente';
      }
    } catch (e) {
      return 'Error al guardar el gasto: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> deleteGasto(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      final String? idx = _editingGasto.idx;
      final String? imageUrl = _editingGasto.gastoModelImageUrl;
      if (idx == null) {
        return 'No fue posible eliminar el gasto';
      } else {
        String? messageError = await deleteImage(imageUrl);
        if (messageError != null &&
            messageError.isNotEmpty &&
            messageError != "") {
          return messageError;
        } else {
          await gastoRepository.deleteGasto(idx);
          clear();
          return 'Gasto eliminado exitosamente';
        }
      }
    } catch (e) {
      return 'Error al eliminar el gasto: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    importController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
