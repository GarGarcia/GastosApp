import 'package:flutte_scanner_empty/data/models/gasto_model.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

List<GastoModel> parseGastos(List<Map<String, dynamic>> response) {
  return response.map((item) => GastoModel.fromJsonMap(item)).toList();
}

class LocalService {
  final _client = Supabase.instance.client;

  Future<void> _hasInternet() async {
    final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)){
      throw 'No hay conexión a Internet';
    }
  }

  Future<List<GastoModel>> getGastos() async {
    await _hasInternet();

    final List<Map<String, dynamic>> response = await _client
        .from('gastos')
        .select()
        .order('created_at', ascending: false);
        
    final List<GastoModel> gastosList = await compute(parseGastos, response);

    return gastosList;
  }

  Future<List<GastoModel>> getGastosByDate(DateTime from, DateTime to) async {
    await _hasInternet();

    if (from.isAfter(to)) {
      throw Exception('La fecha de inicio no puede ser posterior a la fecha de fin');
    }

    final List<Map<String, dynamic>> response = await _client
        .from('gastos')
        .select()
        .gte('created_at', DateFormat('yyyy-MM-dd').format(from))
        .lte('created_at', DateFormat('yyyy-MM-dd').format(to))
        .order('created_at', ascending: false);

    final List<GastoModel> gastosList = await compute(parseGastos, response);
    return gastosList;
  }

  Future<List<GastoModel>> getGastosByFilter(
    DateTime from,
    DateTime to,
    String? cliente,
  ) async {
    await _hasInternet();

    PostgrestFilterBuilder<List<Map<String, dynamic>>> query = _client
        .from('gastos')
        .select()
        .gte('created_at', DateFormat('yyyy-MM-dd').format(from))
        .lte('created_at', DateFormat('yyyy-MM-dd').format(to));
    if (cliente != null && cliente.isNotEmpty) {
      query = query.eq('client', cliente);
    }
    final List<Map<String, dynamic>> response = await query.order('created_at', ascending: false);
    final List<GastoModel> gastosList = await compute(parseGastos, response);
    return gastosList;
  }

  Future<void> addGastos(
    double import,
    String client,
    String description,
    DateTime fecha,
    String imageUrl,
    String imageId,
  ) async {
    await _hasInternet();

    await _client.from('gastos').insert({
      'import': import,
      'client': client,
      'description': description,
      'created_at': DateFormat('yyyy-MM-dd').format(fecha),
      'imageUrl': imageUrl,
      'imageId': imageId,
    });
  }

  Future<void> updateGasto(
    String idx,
    DateTime fecha,
    double import,
    String client,
    String description,
    String imageUrl,
    String imageId,
  ) async {
    await _hasInternet();

    await _client
        .from('gastos')
        .update({
          'import': import,          
          'client': client,
          'description': description,
          'created_at': DateFormat('yyyy-MM-dd').format(fecha),
          'imageUrl': imageUrl,
          'imageId': imageId,
        })
        .eq('idx', idx);
  }

  Future<void> deleteGasto(String id) async {
    await _hasInternet();

    await _client.from('gastos').delete().eq('idx', id);
  }
}
