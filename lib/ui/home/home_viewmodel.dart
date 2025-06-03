import 'package:flutte_scanner_empty/data/models/gasto_model.dart';
import 'package:flutte_scanner_empty/data/repository/gasto_repository.dart';
import 'package:flutte_scanner_empty/data/services/supabase_auth_service.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final GastoRepository gastoRepository;
  final SupabaseAuthService authService;

  List<GastoModel> gastosList = [];
  bool isLoading = false;
  String errorMessage = "";

  HomeViewModel(this.authService, {required this.gastoRepository});

  Future<void> getGastos() async {
    isLoading = true;
    notifyListeners();

    try {
      gastosList = await gastoRepository.getGastos();
      errorMessage = "";
    } catch (e) {
      errorMessage = "Error al obtener los gastos: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logOut() async {
    try {
      await authService.signOut();
      errorMessage = "";
    } catch (e) {
      errorMessage = "Error al cerrar sesión: $e";
    } finally {
      notifyListeners(); 
    }
  }

  String? getEmail() {
    return authService.getCurrentUserEmail();
  }
}
