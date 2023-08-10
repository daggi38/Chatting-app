import 'package:flutter/material.dart';

class isobsecure extends ChangeNotifier {
  bool _isshowing = true;

  get showing => _isshowing;

  void show() {
    _isshowing = !_isshowing;
    notifyListeners();
  }
}


