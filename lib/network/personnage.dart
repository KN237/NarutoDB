class Personnage {
  late String id;
  late String name;
  late String url;
  var images;
  var family;
  var debut;
  var jutsu;
  var personal;
  var rank;
  var voiceActor;

 Personnage.fromJson(Map json){

  id=json['id'].toString();
  name=json['name'];
  images=json['images'];
  debut=json['debut'];
  jutsu=json['jutsu'];
  personal=json['personal'];
  rank=json['rank'];
  voiceActor=json['voiceActors'];
  family=json['family'];
  //url=json['url'];
  //image=json['image'];
  //personnages=json['personnages'];

}
}
