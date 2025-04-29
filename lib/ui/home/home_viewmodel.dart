import 'package:flutte_scanner_empty/data/models/ticket_model.dart';
import 'package:flutte_scanner_empty/data/repository/ticket_repository.dart';
import 'package:flutte_scanner_empty/data/services/supabase_auth_service.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier with RouteAware {
  final TicketRepository ticketRepository;
  final SupabaseAuthService authService;

  List<TicketModel> ticketList = [];
  bool isLoading = false;

  HomeViewModel(this.authService, {required this.ticketRepository});

  Future<void> getGastos() async {
    isLoading = true;
    notifyListeners();

    try {
      ticketList = await ticketRepository.getGastos();
      notifyListeners();
    } catch (e) {
      debugPrint("Error al obtener los tickets: $e");
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
