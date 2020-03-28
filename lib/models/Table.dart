import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Table {


  static void logoutUser() {
    FirebaseAuth.instance.signOut();
  }


  static void insertDocument(String collection, Map<String, dynamic> data) =>
      Firestore.instance.collection(collection).add(data);
  
  static DocumentReference createDocument(String collection, String documentID) {
    return Firestore.instance.collection(collection).document(documentID);
  }

  static DocumentReference getDocumentReference(
          String collection, String documentID) =>
      Firestore.instance.collection(collection).document(documentID);

  static Future<DocumentReference> insertDocumentAndgetIt(
          String collection, Map<String, dynamic> data) async =>
      Firestore.instance.collection(collection).add(data);
  
  static void insertDataInExistingDocument(String collection, String documentID, Map<String, dynamic> data) {
    Firestore.instance.collection(collection).document(documentID).setData(data);
  }

  static Future<DocumentSnapshot> getDocumentSnapshot(
          DocumentReference documentReference) =>
      documentReference.get();
}