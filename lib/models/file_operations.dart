import 'dart:io';
import 'dart:convert';

import 'package:series_list_app/models/series.dart';
import 'package:path_provider/path_provider.dart';

class FileOperations {
  const FileOperations();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/series.txt');
  }

  Future<List<Series>> readFromFile() async {
    try {
      List<Series> series = [];
      final file = await _localFile;
      final fileContents = await file.readAsString();
      for(Map<String, dynamic> seriesMap in jsonDecode(fileContents)) {
        series.add(Series.fromJson(seriesMap));
      }
      return series;
    } catch (e) {
      return [];
    }
  }

  Future<File> writeToFile(String json) async {
    final file = await _localFile;
    return file.writeAsString(json);
  }

  
}