import 'package:flutter/material.dart';
import 'package:thetax_mjpeg/command/thumbs_command.dart';
import 'package:thetax_mjpeg/model/file_notifier.dart';
import 'package:provider/provider.dart';

class FileButtons extends StatelessWidget {
  const FileButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: OutlinedButton(
                onPressed: () => thumbsCommand(context),
                child: const Text('thumbs')),
          ),
          Flexible(
              fit: FlexFit.loose,
              child: Slider(
                value: context.watch<FileNotifier>().numberOfThumbs,
                min: 0,
                max: 1000,
                divisions: 10,
                label: context
                    .watch<FileNotifier>()
                    .numberOfThumbs
                    .ceil()
                    .toString(),
                onChanged: (double value) {
                  context.read<FileNotifier>().setNumberOfThumbs(value);
                },
              )),
          Flexible(
              fit: FlexFit.loose,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('max allowed: ' +
                      context
                          .watch<FileNotifier>()
                          .numberOfThumbs
                          .ceil()
                          .toString()),
                  Text('showing: ' +
                      context.watch<FileNotifier>().thumbs.length.toString()),
                ],
              ))
        ],
      ),
    );
  }
}
