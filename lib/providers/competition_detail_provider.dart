import 'package:flutter/cupertino.dart';
import 'package:football_app/components/failure.dart';
import 'package:football_app/model/competition.dart';
import 'package:football_app/model/competition_detail.dart';
import 'package:football_app/service/api_service.dart';
import 'package:football_app/utils/constants.dart';


class CompetitionDetailProvider extends ChangeNotifier{

  String? currentCompetition;
  CompetitionDetail? competitionDetail;
  final List<Competition> _competitions = competitions;
   bool? isLoading;
  String failureMessage = '';

  CompetitionDetailProvider(){
    currentCompetition ?? _competitions[0].code;

  }

  setCurrentCompetition(int index){
    currentCompetition = _competitions[index].code;
    notifyListeners();
  }

  Future<void> fetchCompetitionDetails() async{
    if(currentCompetition != null) {
      resetValues();
      final result  = await FootballApiService().fetchCompetitionDetail(
          'competitions/$currentCompetition');
      if(result is CompetitionDetail){
        competitionDetail = result;
      } if(result is Failure){
        failureMessage = result.message;
      }

      isLoading = false;
      notifyListeners();
    }
  }
    resetValues(){
    isLoading = true;
    failureMessage = '';
    notifyListeners();
    }
}