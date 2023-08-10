import 'package:flutter/material.dart';

class scrrollfromup extends ChangeNotifier {
  bool _directioin = true;

  get showing => _directioin;

  void scroll() {
    _directioin = !_directioin;
    notifyListeners();
  }
}
