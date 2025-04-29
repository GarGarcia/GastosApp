import 'dart:io';

import 'package:flutte_scanner_empty/core/constants.dart';
import 'package:flutte_scanner_empty/data/repository/ticket_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FormTicketViewmodel extends ChangeNotifier {
  final TicketRepository ticketRepository;
  final supabase = Supabase.instance.client;
  File? image;
  final _picker = ImagePicker();

  FormTicketViewmodel({required this.ticketRepository});

  pickImage(option) async {
    late XFile? pickedFile;

    switch (option) {
      case "galeria":
        pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      case "camara":
        pickedFile = await _picker.pickImage(source: ImageSource.camera);
    }

    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    }
  }

  pickOption(context) {
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

  Future<void> updateGasto(
    String id,
    DateTime fecha,
    double import,
    String client,
    String description,
    String imageUrl,
  ) async {
    await ticketRepository.updateGasto(id, fecha, import, client, description, imageUrl);
  }

Future<void> uploadImage(File imageFile) async {
    final storageResponse = await supabase.storage
        .from('images')
        .upload('public/${imageFile.path.split('/').last}', imageFile);

    if (storageResponse.isNotEmpty) {
      final imageUrl = supabase.storage
          .from('image')
          .getPublicUrl('public/${imageFile.path.split('/').last}');
      await saveImageUrl(imageUrl);
    } else {
      print(
        'Error al subir la imagen: public/${imageFile.path.split('/').last}',
      );
    }
  }

  Future<void> saveImageUrl(String imageUrl) async {
    final response = await supabase.from('your-table-name').insert({
      'image_url': imageUrl,
    });

    if (response.error == null) {
      print('URL guardada exitosamente');
    } else {
      print('Error al guardar la URL: ${response.error.message}');
    }
  }
}