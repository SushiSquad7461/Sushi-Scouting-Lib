import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:sushi_scouts/SushiScoutingLib/logic/network/rest_client.dart';
import 'package:sushi_scouts/SushiScoutingLib/logic/secret/secret.dart';
import 'package:sushi_scouts/SushiScoutingLib/logic/secret/secret_loader.dart';
import 'package:sushi_scouts/SushiScoutingLib/logic/models/scouting_data_models/match_schedule.dart';


class ApiRepository {
  RestClient? _restClient;

  Future<MatchSchedule> getMatchSchedule(String event, String tournamentLevel) async {
    final dio = Dio();
    Secret secrets = await SecretLoader(secretPath: "assets/secrets.json").load();
    dio.options.headers['Authorization'] = 'Basic ${base64.encode(utf8.encode("${secrets?.getApiKey("tbaUsername")}:${secrets?.getApiKey("tbaPassword")}"))}';
    dio.options.headers['If-Modified-Since'] = '';
    _restClient = RestClient(dio, baseUrl: '');
    return await _restClient!.getMatchSchedule(event, tournamentLevel);
  }

  ApiRepository();
}