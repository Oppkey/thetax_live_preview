import 'dart:convert';
import 'package:theta/src/command.dart';
import 'package:http/http.dart' as http;

Future<List<String>> sc2ThumbGetBytes({int number = 5}) async {
  List<String> thumbList = [];
  List<String> fileUrlList = [];
  Map<String, String> headers = {
    "Content-Type": "application/json;charset=utf-8"
  };
  var client = http.Client();

  try {
    var response = await command(
      'listFiles',
      parameters: {
        'fileType': 'image',
        'entryCount': number,
        'maxThumbSize': 0
      },
    );
    Map<String, dynamic> responseMap = jsonDecode(response);
    var fileList = responseMap['results']['entries'];
    for (var entry in fileList) {
      fileUrlList.add(entry['fileUrl']);
    }

    if (number > 100) {
      print('handling SC2 thumbs greater than 100');
      int _totalEntries = responseMap['results']['totalEntries'];
      if (number >= _totalEntries) {
        number = _totalEntries;
      }
      int loops = (number / 100).truncate();
      print('loops: $loops');
      for (int i = 1; i <= loops; i++) {
        int currentEntryCount = 100;
        if (number - 100 * i < 100) {
          currentEntryCount = number - 100 * i;
        }
        var response = await command(
          'listFiles',
          parameters: {
            'fileType': 'image',
            'startPosition': 100 * i,
            'entryCount': currentEntryCount,
            'maxThumbSize': 0
          },
        );
        Map<String, dynamic> responseMap = jsonDecode(response);
        var fileList = responseMap['results']['entries'];
        for (var entry in fileList) {
          fileUrlList.add(entry['fileUrl']);
        }
      }
    }
    for (String fileUrl in fileUrlList) {
      var url = Uri.parse('$fileUrl?type=thumb');
      var response = await client.get(url, headers: headers);
      var thumb64 = base64.encode(response.bodyBytes);
      thumbList.add(thumb64);
    }
  } catch (error) {
    print(error);
  } finally {
    client.close();
  }
  return thumbList;
}
