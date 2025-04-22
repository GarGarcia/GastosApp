import 'package:flutte_scanner_empty/data/repository/ticket_repository.dart';
import 'package:flutte_scanner_empty/data/services/auth_service.dart';
import 'package:flutte_scanner_empty/data/services/local_service.dart';
import 'package:flutte_scanner_empty/ui/auth/login_page.dart';
import 'package:flutte_scanner_empty/ui/home/home_page.dart';
import 'package:flutte_scanner_empty/ui/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: CircularProgressIndicator());
        }

        final session = snapshot.hasData ? snapshot.data!.session : null;

        if(session != null){
          return HomePage(homeViewModel: HomeViewModel(AuthService(), ticketRepository: TicketRepository(localService: LocalService())));
        } else {
          return LoginPage();
        }
      },
    );
  }
}
