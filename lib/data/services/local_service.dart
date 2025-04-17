import 'package:flutte_scanner_empty/data/models/ticket_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LocalService {
  final _client = Supabase.instance.client;

  Future<List<TicketModel>> getGastos() async {
    List<TicketModel> ticketList = [];
    final response = await _client
        .from('gastos')
        .select()
        .order('created_at', ascending: false);

    for (var item in response) {
      final ticket = TicketModel.fromJsonMap(item);
      ticketList.add(ticket);
    }

    return ticketList;
  }

  Future<void> addGastos(
    double import,
    String client,
    String description,
    DateTime fecha,
  ) async {
    await _client.from('gastos').insert({
      'import': import,
      'client': client,
      'description': description,
      'created_at': fecha,
    });
  }

  Future<void> updateGasto(
    String idx,
    DateTime fecha,
    double import,
    String client,
    String description,
  ) async {
    await _client
        .from('gastos')
        .update({
          'created_at': fecha,
          'import': import,
          'client': client,
          'description': description,
        })
        .eq('idx', idx);
  }

  Future<void> deleteGasto(String id) async {
    await _client.from('gastos').delete().eq('idx', id);
  }
}
