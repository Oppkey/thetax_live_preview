import 'package:flutter/material.dart';

class VrNotifier extends ChangeNotifier {
  bool _vr = true;
  bool get vr => _vr;
  void toggleVr() {
    _vr = !_vr;
    notifyListeners();
  }
}
