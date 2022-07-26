import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sushi_scouts/src/logic/constants.dart';
import 'scouting_data.dart';

class ConfigFileReader {
  String configFileFolder;
  int year;
  int? teamNum;
  Map<String, dynamic>? parsedFile;
  static final ConfigFileReader _reader = ConfigFileReader._(CONFIG_FILE_PATH, 2022);

  ConfigFileReader._(this.configFileFolder, this.year);

  static ConfigFileReader get instance => _reader;

  Future<void> readConfig() async {
    try {
      final String stringifiedFile =
          await rootBundle.loadString("$configFileFolder${year}config.json");
      parsedFile = await json.decode(stringifiedFile);
      teamNum = parsedFile!["teamNumber"];
      parsedFile = parsedFile!["scouting"];
      return;
    } catch (e) {
      rethrow;
    }
  }

  List<String> getScoutingMethods() {
    return parsedFile != null ? parsedFile!.keys.toList() : [];
  }

  ScoutingData? generateScoutingData(String scoutingMethod) {
    return ScoutingData(parsedFile![scoutingMethod], name: scoutingMethod);
  }

  List<ScoutingData> getScoutingDataClasses() {
    List<ScoutingData> ret = [];
    for (var scoutingMethod in parsedFile!.keys) {
      ret.add(ScoutingData(parsedFile![scoutingMethod], name: scoutingMethod));
    }
    return ret;
  }

  bool extraFeatureAccess(var AUTHORIZED_TEAMS) {
    return AUTHORIZED_TEAMS.contains(teamNum);
  }
}
