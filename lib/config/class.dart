import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FFUser {
  final String id;
  final String password;
  final String name;
  final String sex;
  final String dep;

  FFUser({required this.id, required this.password, required this.name, required this.sex, required this.dep});

  factory FFUser.fromJson(Map<String, dynamic> json) {
    return FFUser(
      id: json["id"],
      password: json["password"],
      name: json["name"],
      sex: json["sex"],
      dep: json["dep"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "password": password,
      "name": name,
      "sex": sex,
      "dep": dep,
    };
  }
  FFUser.fromQuerySnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot["id"],
        password = snapshot["password"],
        name = snapshot["name"],
        sex = snapshot["sex"],
        dep = snapshot["dep"];
}

class Union{
  final String type;
  final String title;
  final String max;
  String number;
  final String time;
  final String place;
  

  Union({required this.type, required this.title, required this.max, required this.number, required this.time, required this.place});

  factory Union.fromJson(Map<String, dynamic> json) {
    return Union(
      type: json["type"],
      title: json["title"],
      max: json["max"],
      number: json["number"],
      time: json["time"],
      place: json["place"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "title": title,
      "max": max,
      "number": number,
      "time": time,
      "place": place,
    };
  }
  Union.fromQuerySnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : 
        type= snapshot["type"],
        title= snapshot["title"],
        max= snapshot["max"],
        number= snapshot["number"],
        time= snapshot["time"],
        place= snapshot["place"];
}
