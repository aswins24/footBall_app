import 'area.dart';

class Team {
  int? id;
  Area? area;
  String? name;
  String? shortName;
  String? tla;
  String? crestUrl;
  String? address;
  String? phone;
  String? website;
  String? email;
  int? founded;
  String? clubColors;
  String? venue;
  String? lastUpdated;

  Team({this.id, this.area, this.name, this.shortName, this.tla, this.crestUrl, this.address, this.phone, this.website, this.email, this.founded, this.clubColors, this.venue, this.lastUpdated});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    area = json['area'] != null ?  Area.fromJson(json['area']) : null;
    name = json['name'];
    shortName = json['shortName'];
    tla = json['tla'];
    crestUrl = json['crestUrl'];
    address = json['address'];
    phone = json['phone'];
    website = json['website'];
    email = json['email'];
    founded = json['founded'];
    clubColors = json['clubColors'];
    venue = json['venue'];
    lastUpdated = json['lastUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    if (area != null) {
      data['area'] = area!.toJson();
    }
    data['name'] = name;
    data['shortName'] = shortName;
    data['tla'] = tla;
    data['crestUrl'] = crestUrl;
    data['address'] = address;
    data['phone'] = phone;
    data['website'] = website;
    data['email'] = email;
    data['founded'] = founded;
    data['clubColors'] = clubColors;
    data['venue'] = venue;
    data['lastUpdated'] = lastUpdated;
    return data;
  }

  @override
  String toString() {
    return 'Team{id: $id, area: $area, name: $name, shortName: $shortName, tla: $tla, crestUrl: $crestUrl, address: $address, phone: $phone, website: $website, email: $email, founded: $founded, clubColors: $clubColors, venue: $venue, lastUpdated: $lastUpdated}';
  }
}