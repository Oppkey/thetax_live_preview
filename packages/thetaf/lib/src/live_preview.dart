import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class LivePreview extends StatefulWidget {
  const LivePreview(this.controller, {Key? key, this.is360 = false})
      : super(key: key);
  final StreamController controller;
  final bool is360;

  @override
  _LivePreviewState createState() => _LivePreviewState();
}

class _LivePreviewState extends State<LivePreview> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.controller.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var imageData = Uint8List.fromList(snapshot.data);
          return widget.is360
              ? PanoramaViewer(
                  child: Image.memory(
                    imageData,
                    gaplessPlayback: true,
                  ),
                )
              : Image.memory(
                  imageData,
                  gaplessPlayback: true,
                );
        } else {
          return Container();
        }
      },
    );
  }
}
