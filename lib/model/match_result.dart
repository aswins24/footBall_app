class MatchResult{
  int? homeTeamId;
  int? awayTeamId;
  String? winner;

  MatchResult.fromJson(Map<String, dynamic>json){
    homeTeamId = json['homeTeam']['id'];
    awayTeamId = json['awayTeam']['id'];
    winner = json['score']['winner'];
  }

  @override
  String toString() {
    return 'MatchResult{homeTeamId: $homeTeamId, awayTeamId: $awayTeamId, winner: $winner}';
  }
}