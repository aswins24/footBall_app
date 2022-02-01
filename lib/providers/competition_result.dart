import 'package:flutter/cupertino.dart';
import 'package:football_app/components/failure.dart';
import 'package:football_app/model/match_result.dart';
import 'package:football_app/model/team.dart';
import 'package:football_app/providers/competition_detail_provider.dart';
import 'package:football_app/providers/team_detail_provider.dart';
import 'package:football_app/service/api_service.dart';
import 'package:intl/intl.dart';

class CompetitionResult with ChangeNotifier{

  TeamDetails? teamDetails;
  String?  currentCompetition;
  List<MatchResult> matchResults = [];
  CompetitionResult( this.teamDetails, );
  Map<Team, int> scoreTracker={};
  int maxScore = 0;
  Team? team ;
  bool isLoading = true;
  String startDateAsString ='';
  String endDateAsString ='';
  String failureMessage ='';

  update( TeamDetails teamDetails){

    currentCompetition = teamDetails.currentCompetition;
    this.teamDetails = teamDetails;
    isLoading = true;
    failureMessage = '';
  }
  DateTime calculateFilteringDate(DateTime endDate){
    int difference = DateTime.now().difference(endDate).inMinutes;
    if(difference < 0){
      return DateTime.now();
    } else if(difference > 0){
      return endDate;
    } else{
      return endDate.subtract(const Duration(days: 1));
    }
  }

  Future<void> fetchMatchResults() async{
    if(teamDetails != null && teamDetails!.competitionDetailProvider!.competitionDetail != null) {

      resetValues();
      DateTime competitionEndDate = DateTime.parse(teamDetails!.competitionDetailProvider!.competitionDetail!.currentSeason!.endDate!);
      DateTime endDate = calculateFilteringDate(competitionEndDate);
      DateTime startingDate = calculateStartingDate(endDate);

       startDateAsString = dateAsString(startingDate);
       endDateAsString = dateAsString(endDate);

      final result = await FootballApiService().fetchMatchResultsForCompetition(
          'competitions/$currentCompetition/matches?dateFrom=$startDateAsString&dateTo=$endDateAsString');
      if(result is List<MatchResult>){
        matchResults = result;
      } else if(result is Failure){
        failureMessage = result.message;
      }
      isLoading = false;
      notifyListeners();
      createScoreTracker();
    }


  }

  calculateStartingDate(DateTime endDate){
    return endDate.subtract(const Duration(days: 30));
  }

  dateAsString (DateTime date){
    return DateFormat('yyyy-MM-dd').parse(date.toString()).toString().split(' ')[0];
  }

  createScoreTracker(){
    for (var result in matchResults) {
      int? winnerId = result.winner == 'HOME_TEAM'
          ? result.homeTeamId
          : result.winner == 'AWAY_TEAM' ? result.awayTeamId : -1;
      if (teamDetails != null && winnerId != -1 && teamDetails!.teams[winnerId] != null) {
        scoreTracker.update(teamDetails!.teams[winnerId]!, (value) => value+1,ifAbsent: () =>1);

      }
    }
    findMaxWinTeam();
  }

  findMaxWinTeam(){
    scoreTracker.forEach((key, value) {
      if (value > maxScore) {
        maxScore = value;
        team = key;
      }
    });
    print('Max score is $maxScore and team is $team');
    notifyListeners();
  }

  resetValues(){
    isLoading = true;
    scoreTracker = {};
    maxScore = 0;
    team = null;
    startDateAsString = '';
    endDateAsString = '';
    failureMessage = '';
    notifyListeners();
  }
}