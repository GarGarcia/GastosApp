import 'package:flutte_scanner_empty/data/models/gasto_model.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LocalService {
  final _client = Supabase.instance.client;

  Future<List<GastoModel>> getGastos() async {
    List<GastoModel> gastosList = [];
    final response = await _client
        .from('gastos')
        .select()
        .order('created_at', ascending: false);

    for (var item in response) {
      final gastos = GastoModel.fromJsonMap(item);
      gastosList.add(gastos);
    }

    return gastosList;
  }

  Future<void> addGastos(
    double import,
    String client,
    String description,
    DateTime fecha,
    String imageUrl,
  ) async {
    await _client.from('gastos').insert({
      'import': import,
      'client': client,
      'description': description,
      'created_at': DateFormat('yyyy-MM-dd').format(fecha),
      'imageUrl': imageUrl,
    });
  }

  Future<void> updateGasto(
    String idx,
    DateTime fecha,
    double import,
    String client,
    String description,
    String imageUrl,
  ) async {
    await _client
        .from('gastos')
        .update({
          'import': import,          
          'client': client,
          'description': description,
          'created_at': DateFormat('yyyy-MM-dd').format(fecha),
          'imageUrl': imageUrl,
        })
        .eq('idx', idx);
  }

  Future<void> deleteGasto(String id) async {
    await _client.from('gastos').delete().eq('idx', id);
  }
}
