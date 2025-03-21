import 'package:flutte_scanner_empty/source/models/country_model.dart';
import 'package:flutter/material.dart';

class GlobalProvider extends ChangeNotifier{
  Country _mCountry = Country();
  Country get mCountry => _mCountry;
  set mCountry (Country mCountry){
    _mCountry = mCountry;
    notifyListeners();
  } 
}