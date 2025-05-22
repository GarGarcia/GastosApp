import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

class FormGastosViewModel extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  Cliente? cliente;
  DateTime? selectedDate;
  File? selectedImage;
  bool isLoading = false;

  void setCliente(Cliente? value) {
    cliente = value;
    notifyListeners();
  }

  void setDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      selectedImage = File(picked.path);
      notifyListeners();
    }
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate() ||
        cliente == null ||
        selectedDate == null ||
        selectedImage == null) {
      return;
    }

    isLoading = true;
    notifyListeners();

    final userId = supabase.auth.currentUser?.id;
    final imageBytes = await selectedImage!.readAsBytes();
    final imageName = "${DateTime.now().millisecondsSinceEpoch}_$userId.jpg";
    final storagePath = 'Gastoss/$imageName';

    await supabase.storage
        .from("images")
        .uploadBinary(
          storagePath,
          imageBytes,
          fileOptions: const FileOptions(contentType: 'image/jpeg'),
        );

    final imageUrl = supabase.storage.from("images").getPublicUrl(storagePath);

    await supabase.from('gastos').insert({
      'titulo': titleController.text.trim(),
      'precio': double.parse(priceController.text),
      'fecha': selectedDate,
      'cliente': cliente!.label,
      'user_id': userId,
      'imagen_url': imageUrl,
    });

    isLoading = false;
    notifyListeners();
  }
}
