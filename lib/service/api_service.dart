import 'package:football_app/components/failure.dart';
import 'package:football_app/helper/http_helper.dart';
import 'package:football_app/model/competition_detail.dart';
import 'package:football_app/model/match_result.dart';
import 'package:football_app/model/team.dart';

abstract class ApiService{

fetchCompetitionDetail(String url);

fetchTeamsForCompetition(String url);

fetchMatchResultsForCompetition(String url);


}

class FootballApiService extends ApiService{
  @override
  fetchCompetitionDetail(String url) async{
    // TODO: implement fetchMatchResults

   try{
     final jsonResponse = await HttpHelper().get(params: '$url/');
    return CompetitionDetail.fromJson(jsonResponse);
   }on Failure catch(e){
     return e;
   }
  }

  @override
  fetchTeamsForCompetition(String url) async{
    // TODO: implement fetchTeamsForCompetition


    try{
      final jsonResponse = await HttpHelper().get(params: '$url/');
      List<Team> teamList =[];
      if(jsonResponse != null) {
        teamList = List.from(jsonResponse['teams'])
            .map((e) => Team.fromJson(e))
            .toList();
      }

   Map<int?, Team> teams = { for (var v in teamList) v.id : v };
    //  print(teams);
      return teams;
    }on Failure catch(e){
     return e;
    }

  }

  @override
  fetchMatchResultsForCompetition(String url) async{


    try{
      final jsonResponse = await HttpHelper().get(params: '$url');
      List<MatchResult> matchResults =[];
      matchResults = List.from(jsonResponse['matches']).map((e) => MatchResult.fromJson(e)).toList();
      

  //    print(matchResults);
      return matchResults;
    }on Failure catch (e){
      return e;
    }
  }



}