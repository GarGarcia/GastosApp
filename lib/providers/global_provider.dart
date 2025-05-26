import 'package:flutte_scanner_empty/data/models/gasto_model.dart';
import 'package:flutter/material.dart';

class GlobalProvider extends ChangeNotifier {
  GastoModel _mGasto = GastoModel();
  GastoModel get mGasto => _mGasto;
  set mGastos(GastoModel mGasto) {
    _mGasto = mGasto;
    notifyListeners();
  }
}
