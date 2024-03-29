import 'package:flutter/material.dart';
import 'package:thetax_mjpeg/model/layout_notifier.dart';
import 'package:thetax_mjpeg/model/video_notifier.dart';
import 'package:theta/theta.dart';
import 'package:thetax_mjpeg/model/vr_notifier.dart';

import 'home_buttons.dart';
import 'home_response.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RICOH THETA Live Preview'),
        backgroundColor: Colors.lightGreen,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButton(
                // value: context.watch<ScreenNotifer>().screen,

                items: <String>['file', 'camera']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: const Text('screens'),
                style: const TextStyle(color: Colors.black),
                onChanged: (String? newValue) {
                  if (newValue == 'file') {
                    Navigator.pushNamed(context, '/file');
                  } else if (newValue == 'camera') {
                    Navigator.pushNamed(context, '/camera');
                  }
                },
              ),
              const SizedBox(width: 100),
              TextButton(
                  onPressed: () {
                    context.read<VideoNotifier>().setVideoRunning(false);
                    Preview.stopPreview();
                    Provider.of<LayoutNotifier>(context, listen: false)
                        .toggleLandscape();
                  },
                  child: Text(context.watch<LayoutNotifier>().landscape
                      ? 'portait'
                      : 'landscape')),
              TextButton(
                  onPressed: () {
                    context.read<VideoNotifier>().setVideoRunning(false);
                    Preview.stopPreview();
                    Provider.of<VrNotifier>(context, listen: false).toggleVr();
                  },
                  child: Text(context.watch<VrNotifier>().vr ? 'rect' : '360')),

              // const Text('sc2 experiment'),
              // Switch(
              //     value: context.watch<VideoNotifier>().sc2Experiment,
              //     onChanged: (value) {
              //       Provider.of<VideoNotifier>(context, listen: false)
              //           .setSc2Experiment(value);
              //       print(value);
              //     }),
            ],
          ),
          const SizedBox(
            width: 100,
          ),
        ],
      ),
      body: context.watch<LayoutNotifier>().landscape
          ? Stack(
              children: [
                Container(
                    alignment: Alignment.centerRight,
                    child: const HomeResponse()),
                const HomeButtons(
                  row: false,
                ),
              ],
            )
          : const Stack(
              children: [
                HomeResponse(),
                HomeButtons(),
              ],
            ),
    );
  }
}
