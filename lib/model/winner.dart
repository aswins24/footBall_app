class Winner{
  int? id;
  String? name;
  String? shortName;
  String? tla;
  String? crestUrl;

  Winner({this.id, this.name, this.shortName, this.tla, this.crestUrl});

  Winner.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
    tla = json['tla'];
    crestUrl = json['crestUrl'];
  }

  Map<String,dynamic> toJson(){
    return {'id':id, 'name':name,'shortName': shortName, 'tla':tla,'crestUrl':crestUrl };
  }
}