import 'package:cloud_firestore/cloud_firestore.dart';

mixin FireBaseMixin{
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> getDocs(String collectionName) async{
    final snapshot = await db.collection(collectionName).get();
    return snapshot.docs;
  }

  Future<DocumentSnapshot> getDocumentById(String collectionName, {required String documentId}) async {
    return db.collection(collectionName).doc(documentId).get();
  }

  Future<void> deleteDoc(String collectionName, {required String documentId}) async {
    db.collection(collectionName).doc(documentId).delete();
  }

  Future<void> updateDoc(String collectionName, {required String documentId, required Map<String, dynamic> data} ) async {
    print(collectionName);
    print(documentId);
    print(data);
    db.collection(collectionName).doc(documentId).update(data);
  }
}