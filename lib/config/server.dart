import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_friend/config/class.dart';

Future<List<FFUser>> getFireModels() async {
  CollectionReference<Map<String, dynamic>> collectionReference =
      FirebaseFirestore.instance.collection("user");
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await collectionReference.orderBy("id").get();

  List<FFUser> users = [];
  for (var doc in querySnapshot.docs) {
    FFUser fireModel = FFUser.fromJson(doc.data());
    users.add(fireModel);
  }
  return users;
}

Future<List<Union>> getFireUnion() async {
  CollectionReference<Map<String, dynamic>> collectionReference =
      FirebaseFirestore.instance.collection("union");
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await collectionReference.orderBy("type").get();

  List<Union> unions = [];
  for (var doc in querySnapshot.docs) {
    Union fireModel = Union.fromJson(doc.data());
    unions.add(fireModel);
  }
  return unions;
}

Future<void> deleteCollection(String collectionName, String field1Name, dynamic value1, String field2Name, dynamic value2) async {
  
  CollectionReference collectionRef = FirebaseFirestore.instance.collection(collectionName);
  
  QuerySnapshot querySnapshot = await collectionRef.where(field1Name, isEqualTo: value1).where(field2Name, isEqualTo: value2).get();
  
  querySnapshot.docs.forEach((doc) {
    doc.reference.delete();
  });
}

Future<void> updateData() async {
  
}