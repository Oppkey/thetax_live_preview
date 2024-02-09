import 'package:flutter/widgets.dart';
import 'package:thetax_mjpeg/model/response_notifier.dart';
import 'package:thetax_mjpeg/model/video_notifier.dart';
import 'package:provider/provider.dart';
import 'package:thetaf/thetaf.dart';
import 'package:thetax_mjpeg/model/vr_notifier.dart';

class HomeResponse extends StatelessWidget {
  const HomeResponse({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.watch<VideoNotifier>().videoRunning
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: LivePreview(
              context.watch<VideoNotifier>().controller,
              is360: context.watch<VrNotifier>().vr,
            ),
          )
        : Text(context.watch<ResponseNotifier>().responseText);
  }
}
