import 'dart:async';
import 'package:flutter/material.dart';
import 'package:thetax_mjpeg/model/response_notifier.dart';
import 'package:thetax_mjpeg/model/video_notifier.dart';
import 'package:provider/provider.dart';
import 'package:theta/theta.dart';

class HomeButtons extends StatelessWidget {
  final bool row;
  const HomeButtons({
    this.row = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var buttons = [
      OutlinedButton(
        onPressed: () async {
          var response =
              await setOption(name: '_cameraControlSource', value: 'app');
          context.read<ResponseNotifier>().setResponseText(response);
        },
        child: const Text('X'),
      ),
      OutlinedButton(
        onPressed: () async {
          var response = await ThetaBase.get('info');
          context.read<ResponseNotifier>().setResponseText(response);
        },
        child: const Text('info'),
      ),
      IconButton(
        onPressed: () {
          context.read<VideoNotifier>().setVideoRunning(true);
          try {
            context.read<VideoNotifier>().controller.close;
          } catch (error) {
            // print('controller already closed');
            // print(error);
          }
          context.read<VideoNotifier>().setController(StreamController());
          bool sc2Experiment = context.read<VideoNotifier>().sc2Experiment;
          sc2Experiment
              ? Sc2Preview.getLivePreview(
                  frames: -1,
                  frameDelay: 250,
                  controller: Provider.of<VideoNotifier>(context, listen: false)
                      .controller)
              : Preview.getLivePreview(
                  frames: -1,
                  controller: Provider.of<VideoNotifier>(context, listen: false)
                      .controller);
        },
        iconSize: 40.0,
        icon: const Icon(Icons.play_circle_outlined),
      ),
      IconButton(
          onPressed: () {
            context.read<VideoNotifier>().setVideoRunning(false);
            Preview.stopPreview();
          },
          iconSize: 40.0,
          icon: const Icon(Icons.stop_circle_outlined))
    ];
    return row
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buttons,
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buttons,
          );
  }
}
