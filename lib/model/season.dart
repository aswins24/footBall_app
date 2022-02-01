import 'package:football_app/model/winner.dart';

class Season {
  int? id;
  String? startDate;
  String? endDate;
  int? currentMatchday;
  Winner? winner;

  Season(
      {this.id,
        this.startDate,
        this.endDate,
        this.currentMatchday,
        this.winner});

  Season.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    currentMatchday = json['currentMatchday'];
    winner = json['winner'] != null ?Winner.fromJson(json['winner']):null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['currentMatchday'] = currentMatchday;
    data['winner'] = winner!.toJson();
    return data;
  }
}