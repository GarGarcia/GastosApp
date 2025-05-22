import 'package:flutte_scanner_empty/data/models/gasto_model.dart';
import 'package:flutter/material.dart';

class GlobalProvider extends ChangeNotifier {
  GastoModel _mGastos = GastoModel();
  GastoModel get mGastos => _mGastos;
  set mGastos(GastoModel mGastos) {
    _mGastos = mGastos;
    notifyListeners();
  }
}
