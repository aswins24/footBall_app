import 'area.dart';
import 'season.dart';
class CompetitionDetail {
  int? id;
  Area? area;
  String? name;
  String? code;
  String? emblemUrl;
  String? plan;
  Season? currentSeason;
  List<Season>? seasons =[];
  String? lastUpdated;

  CompetitionDetail(
      {this.id,
        this.area,
        this.name,
        this.code,
        this.emblemUrl,
        this.plan,
        this.currentSeason,
        this.seasons,
        this.lastUpdated});

  CompetitionDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    area = json['area'] != null ?  Area.fromJson(json['area']) : null;
    name = json['name'];
    code = json['code'];
    emblemUrl = json['emblemUrl'];
    plan = json['plan'];
    currentSeason = json['currentSeason'] != null
        ?  Season.fromJson(json['currentSeason'])
        : null;
    if (json['seasons'] != null) {
      seasons =  [];
      json['seasons'].forEach((v) {
        seasons!.add( Season.fromJson(v));
      });
    }
    lastUpdated = json['lastUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    if (area != null) {
      data['area'] = area!.toJson();
    }
    data['name'] = name;
    data['code'] = code;
    data['emblemUrl'] = emblemUrl;
    data['plan'] = plan;
    if (currentSeason != null) {
      data['currentSeason'] = currentSeason!.toJson();
    }
    if (seasons != null) {
      data['seasons'] = seasons!.map((v) => v.toJson()).toList();
    }
    data['lastUpdated'] = lastUpdated;
    return data;
  }
}

// class Area {
//   int id;
//   String name;
//
//   Area({this.id, this.name});
//
//   Area.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     return data;
//   }
// }

// class Season {
//   int? id;
//   String? startDate;
//   String? endDate;
//   int? currentMatchday;
//   String? winner;
//
//   Season(
//       {this.id,
//         this.startDate,
//         this.endDate,
//         this.currentMatchday,
//         this.winner});
//
//   Season.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     startDate = json['startDate'];
//     endDate = json['endDate'];
//     currentMatchday = json['currentMatchday'];
//     winner = json['winner'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  <String, dynamic>{};
//     data['id'] = id;
//     data['startDate'] = startDate;
//     data['endDate'] = endDate;
//     data['currentMatchday'] = currentMatchday;
//     data['winner'] = winner;
//     return data;
//   }
// }
