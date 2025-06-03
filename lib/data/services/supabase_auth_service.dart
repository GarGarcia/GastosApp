import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> _hasInternet() async {
    final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw 'No hay conexión a Internet';
    }
  }

  //Sign in with email and password
  Future<AuthResponse> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    await _hasInternet();

    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  //Sign up with email and password
  Future<AuthResponse> signUpWithEmailPassword(String email, String password ) async {
    await _hasInternet();

    return await _supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  //Sign out
  Future<void> signOut() async {
    await _hasInternet();

    await _supabase.auth.signOut();
  }

  //Get user email
  String? getCurrentUserEmail() {
    _hasInternet(); 

    final Session? session = _supabase.auth.currentSession;
    final User? user = session?.user;
    return user?.email;
  }
}
