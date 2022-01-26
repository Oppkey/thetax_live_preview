import 'package:flutter/material.dart';

class LayoutNotifier extends ChangeNotifier {
  bool _landscape = true;
  bool get landscape => _landscape;
  void toggleLandscape() {
    _landscape = !_landscape;
    notifyListeners();
  }
}
