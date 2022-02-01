import 'package:flutter/cupertino.dart';
import 'package:football_app/components/failure.dart';
import 'package:football_app/model/team.dart';
import 'package:football_app/providers/competition_detail_provider.dart';
import 'package:football_app/service/api_service.dart';

class TeamDetails with ChangeNotifier {
  CompetitionDetailProvider? competitionDetailProvider;
  String? currentCompetition;
  Map<int?, Team> teams = {};
  bool isLoading = true;
  String failureMessage = '';

  TeamDetails(this.competitionDetailProvider) {
    if (competitionDetailProvider != null) {
      currentCompetition = competitionDetailProvider!.currentCompetition;
      teams = {};
    }
  }

  Future<void> fetchTeamsForCompetition() async {
    if (competitionDetailProvider!.currentCompetition != null) {
      resetValues();
      final result = await FootballApiService()
          .fetchTeamsForCompetition('competitions/$currentCompetition/teams');

      if (result is Map<int?, Team>) {
        teams = result;
      }
      if (result is Failure) {
        failureMessage = result.message;
      }
      isLoading = false;
      notifyListeners();
    }
  }

  update(CompetitionDetailProvider competitionDetailProvider) {
    this.competitionDetailProvider = competitionDetailProvider;
    currentCompetition = competitionDetailProvider.currentCompetition;
    failureMessage ='';
    teams = {};
  //  notifyListeners();
  }

  resetValues() {
    isLoading = true;
    failureMessage = '';
    notifyListeners();
  }
}
