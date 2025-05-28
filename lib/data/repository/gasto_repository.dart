import 'package:flutte_scanner_empty/data/models/gasto_model.dart';
import 'package:flutte_scanner_empty/data/services/local_service.dart';

class GastoRepository {
  final LocalService localService;

  GastoRepository({required this.localService});

  Future<List<GastoModel>> getGastos() async {
    return await localService.getGastos();
  }

  Future<void> updateGasto(
    String id,
    DateTime fecha,
    double import,
    String client,
    String description,
    String imageUrl,
    String imageId,
  ) async {
    await localService.updateGasto(
      id,
      fecha,
      import,
      client,
      description,
      imageUrl,
      imageId,
    );
  }

  Future<void> addGasto(
    DateTime fecha,
    double import,
    String client,
    String description,
    String imageUrl,
    String imageId,
  ) async {
    await localService.addGastos(import, client, description, fecha, imageUrl, imageId);
  }

  Future<void> deleteGasto(String id) async {
    await localService.deleteGasto(id);
  }
}
