import 'dart:async';

import 'package:flutter/material.dart';

class VideoNotifier extends ChangeNotifier {
  bool _videoRunning = false;
  bool get videoRunning => _videoRunning;
  void setVideoRunning(videoRunning) {
    _videoRunning = videoRunning;
    notifyListeners();
  }

  StreamController _controller = StreamController();
  StreamController get controller => _controller;
  void setController(controller) {
    _controller = controller;
    notifyListeners();
  }

  bool _sc2Experiment = false;
  bool get sc2Experiment => _sc2Experiment;
  void setSc2Experiment(sc2Experiment) {
    _sc2Experiment = sc2Experiment;
    notifyListeners();
  }
}
