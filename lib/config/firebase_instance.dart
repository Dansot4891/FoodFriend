import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_friend/config/class.dart';

FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

// Future<List<FFUser>> getFireModels() async {
//   CollectionReference<Map<String, dynamic>> collectionReference =
//       FirebaseFirestore.instance.collection("user");
//   QuerySnapshot<Map<String, dynamic>> querySnapshot =
//       await collectionReference.orderBy("id").get();

//   List<FFUser> users = [];
//   for (var doc in querySnapshot.docs) {
//     FFUser fireModel = FFUser.fromJson(doc.data());
//     users.add(fireModel);
//   }
//   return users;
// }

// Future<List<Union>> getFireUnion() async {
//   CollectionReference<Map<String, dynamic>> collectionReference =
//       FirebaseFirestore.instance.collection("union");
//   QuerySnapshot<Map<String, dynamic>> querySnapshot =
//       await collectionReference.orderBy("type").get();

//   List<Union> unions = [];
//   for (var doc in querySnapshot.docs) {
//     Union fireModel = Union.fromJson(doc.data());
//     unions.add(fireModel);
//   }
//   return unions;
// }

// Future<void> deleteCollection(String collectionName, String field1Name, dynamic value1, String field2Name, dynamic value2) async {
  
//   CollectionReference collectionRef = FirebaseFirestore.instance.collection(collectionName);
  
//   QuerySnapshot querySnapshot = await collectionRef.where(field1Name, isEqualTo: value1).where(field2Name, isEqualTo: value2).get();
  
//   querySnapshot.docs.forEach((doc) {
//     doc.reference.delete();
//   });
// }

// void updateUnionByName(String userid, String title, String newtitle, String max, String place, String time, String type) {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   firestore.collection('union')
//     .where('userid', isEqualTo: userid).where('title', isEqualTo: title)
//     .get()
//     .then((QuerySnapshot querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         firestore.collection('union').doc(doc.id).update({
//           'title' : newtitle,
//           'max' : max,
//           'place' : place,
//           'time' : time,
//           'type' : type,
//         }).then((_) {
//           print('데이터 업데이트 완료');
//         }).catchError((error) {
//           print('데이터 업데이트 실패: $error');
//         });
//       });
//     }).catchError((error) {
//       print('문서 찾기 실패: $error');
//     });
// }

// void enterUnion(String place, String title, String num) {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   firestore.collection('union')
//     .where('place', isEqualTo: place).where('title', isEqualTo: title)
//     .get()
//     .then((QuerySnapshot querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         firestore.collection('union').doc(doc.id).update({
//           'number' : num,
//         }).then((_) {
//           print('데이터 업데이트 완료');
//         }).catchError((error) {
//           print('데이터 업데이트 실패: $error');
//         });
//       });
//     }).catchError((error) {
//       print('문서 찾기 실패: $error');
//     });
// }

