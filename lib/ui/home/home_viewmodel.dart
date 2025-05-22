import 'package:flutte_scanner_empty/data/models/gasto_model.dart';
import 'package:flutte_scanner_empty/data/repository/gasto_repository.dart';
import 'package:flutte_scanner_empty/data/services/supabase_auth_service.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier with RouteAware {
  final GastoRepository gastoRepository;
  final SupabaseAuthService authService;

  List<GastoModel> gastosList = [];
  bool isLoading = false;

  HomeViewModel(this.authService, {required this.gastoRepository});

  Future<void> getGastos() async {
    isLoading = true;
    notifyListeners();

    try {
      gastosList = await gastoRepository.getGastos();
      notifyListeners();
    } catch (e) {
      debugPrint("Error al obtener los Gastoss: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void logOut() async {
    await authService.signOut();
  }

  String? getEmail() {
    return authService.getCurrentUserEmail();
  }
}
