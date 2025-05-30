import 'package:flutte_scanner_empty/data/models/gasto_model.dart';
import 'package:flutte_scanner_empty/data/repository/gasto_repository.dart';
import 'package:flutte_scanner_empty/data/services/supabase_auth_service.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final GastoRepository gastoRepository;
  final SupabaseAuthService authService;

  List<GastoModel> gastosList = [];
  bool isLoading = false;
  DateTimeRange? selectedRange;
  String? selectedCliente;

  HomeViewModel(this.authService, {required this.gastoRepository});

  void setDateRange(DateTimeRange? range) {
    selectedRange = range;
    notifyListeners();
  }

  void setCliente(String? cliente) {
    selectedCliente = cliente;
    notifyListeners();
  }

  Future<void> getGastos() async {
    isLoading = true;
    notifyListeners();
    try {
      DateTime from =
          selectedRange?.start ?? DateTime.now().subtract(Duration(days: 30));
      DateTime to = selectedRange?.end ?? DateTime.now();
      gastosList = await gastoRepository.getGastosByFilter(
        from: from,
        to: to,
        cliente: selectedCliente,
      );
    } catch (e) {
      debugPrint("Error al obtener los Gastos: $e");
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
