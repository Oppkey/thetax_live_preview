import 'dart:convert';

import 'package:theta/src/command.dart';

Future<List<String>> thumbGetBytes({int number = 5}) async {
  List<String> thumbList = [];

  try {
    var response = await command(
      'listFiles',
      parameters: {
        'fileType': 'image',
        'entryCount': number,
        'maxThumbSize': 640
      },
    );
    Map<String, dynamic> responseMap = jsonDecode(response);
    var _entries = responseMap['results']['entries'];
    for (var entry in _entries) {
      String thumbEntry = entry['thumbnail'];
      thumbList.add(thumbEntry);
    }
    // handle more than 100 entries
    if (number > 100) {
      // print('handling thumbs greater than 100');

      int _totalEntries = responseMap['results']['totalEntries'];
      if (number >= _totalEntries) {
        number = _totalEntries;
      }
      int loops = (number / 100).truncate();
      // print('loops: $loops');

      for (int i = 1; i <= loops; i++) {
        int currentEntryCount = 100;
        if (number - 100 * i < 100) {
          currentEntryCount = number - 100 * i;
        }
        var response = await command(
          'listFiles',
          parameters: {
            'fileType': 'image',
            'entryCount': currentEntryCount,
            'startPostion': 100 * i,
            'maxThumbSize': 640
          },
        );

        Map<String, dynamic> responseMap = jsonDecode(response);
        var _currentEntries = responseMap['results']['entries'];
        for (var entry in _currentEntries) {
          String thumbEntry = entry['thumbnail'];
          thumbList.add(thumbEntry);
        }
      }

      //   thumbList.addAll(currentEntries);
      // }
    }
  } catch (error) {
    print(error);
  }
  return thumbList;
}
