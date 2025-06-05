import 'dart:convert';

class GastoModel {
  String? idx;
  double? gastoModelImport;
  String? gastoModelClient;
  String? gastoModelDescription;
  DateTime? gastoModelCreatedAt;
  DateTime? gastoModelUpdatedAt;
  String? gastoModelImageUrl;
  String? gastoModelImageId;

  GastoModel({
    String? idx,
    double? gastoModelImport,
    String? gastoModelClient,
    String? gastoModelDescription,
    dynamic gastoModelCreatedAt,
    dynamic gastoModelUpdatedAt,
    String? gastoModelImageUrl,
    String? gastoModelImageId,
  });

  GastoModel.fromJsonMap(Map<String, dynamic> json) {
    idx = json['idx'];
    final importValue = json['import'];
    if (importValue is int) {
      gastoModelImport = importValue.toDouble();
    } else if (importValue is double) {
      gastoModelImport = importValue;
    } else {
      gastoModelImport = null;
    }
    gastoModelClient = json['client'];
    gastoModelDescription = json['description'];
    gastoModelCreatedAt =
        json['created_at'] == null ? null : DateTime.parse(json['created_at']);
    gastoModelUpdatedAt =
        json['updated_at'] == null ? null : DateTime.parse(json['updated_at']);
    gastoModelImageUrl = json['imageUrl'];
    gastoModelImageId = json['imageId'];
  }

  String toJson() {
    return jsonEncode(_toJsonMap());
  }

  Map<String, dynamic> _toJsonMap() => {
    'idx': idx,
    'import': gastoModelImport,
    'client': gastoModelClient,
    'description': gastoModelDescription,
    'created_at': gastoModelCreatedAt,
    'updated_at': gastoModelUpdatedAt,
    'imageUrl': gastoModelImageUrl,
    'imageId': gastoModelImageId,
  };
}
