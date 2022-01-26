import 'package:flutter/material.dart';
import 'package:thetax_mjpeg/model/file_notifier.dart';
import 'package:provider/provider.dart';
import 'package:theta/theta.dart';

void thumbsCommand(BuildContext context) async {
  int numberOfThumbs = context.read<FileNotifier>().numberOfThumbs.round();
  bool showSc2 = context.read<FileNotifier>().sc2Fix1;
  List<String> thumbs = showSc2
      ? await sc2ThumbGetBytes(number: numberOfThumbs)
      : await thumbGetBytes(number: numberOfThumbs);
  Provider.of<FileNotifier>(context, listen: false).setThumbs(thumbs);
}
