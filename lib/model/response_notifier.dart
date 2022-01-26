import 'package:flutter/material.dart';

class ResponseNotifier extends ChangeNotifier {
  String _responseText = 'camera response';
  String get responseText => _responseText;
  void setResponseText(responseText) {
    _responseText = responseText;
    notifyListeners();
  }
}
