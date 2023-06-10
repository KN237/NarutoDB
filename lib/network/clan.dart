
class Clan {
 late String   id;
 late String  name ;
 String   url="";
 late String   image="assets/images/uchiha.png";
 late  List<int>   personnages;

Clan.fromJson(Map json){

  id=json['id'].toString();
  name=json['name'];
  //url=json['url'];
  //image=json['image'];
  //personnages=json['personnages'];

}

Map toJson(){
  return {'id':id, 'name':name, 'url':url, 'image':image, 'personnages':personnages};
}

}
