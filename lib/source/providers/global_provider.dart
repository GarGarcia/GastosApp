import 'package:flutter/material.dart';

class GlobalProvider extends ChangeNotifier{
  String _mToken = "";
  String get mToken => _mToken;
  set mToken(String nToken) {
    _mToken = nToken;
    notifyListeners();
  }
}