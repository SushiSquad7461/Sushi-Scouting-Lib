import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:sushi_scouts/SushiScoutingLib/logic/models/match_schedule.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: '')
abstract class RestClient {
  factory RestClient(Dio dio, {required String baseUrl}) = _RestClient;

  @GET('https://frc-api.firstinspires.org/v3.0/2020/schedule/{eventCode}?tournamentLevel={tournamentLevel}')
  Future<MatchSchedule> getMatchSchedule(
    @Path('eventCode') String eventCode,
    @Path('tournamentLevel') String tournamentLevel
  );

}