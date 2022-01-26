import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:thetax_mjpeg/model/file_notifier.dart';
import 'package:provider/provider.dart';

class FileResponse extends StatelessWidget {
  const FileResponse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 8,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  childAspectRatio: 2 / 1,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3),
              itemCount: context.watch<FileNotifier>().thumbs.length,
              itemBuilder: (context, index) {
                var thumbs64 = context.watch<FileNotifier>().thumbs;
                var thumbList = [];
                for (String thumb in thumbs64) {
                  var decodedThumb = base64Decode(thumb);
                  thumbList.add(decodedThumb);
                }
                return Image.memory(thumbList[index]);
              }),
        ));
  }
}
