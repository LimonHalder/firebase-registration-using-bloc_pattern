

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class SearchRepository {
  final _firebaseFirestore = Firestore.instance;
  //final FirebaseAuth _firebaseAuth;
 //final Firestore _firebaseFirestore;
  SearchRepository({Firestore firebaseFirestore});

  Future getData(String collection) async {
    QuerySnapshot snapshot =
        await _firebaseFirestore.collection(collection).getDocuments();
    return snapshot.documents;
  }

  Future queryData(String queryString) async {
  return  _firebaseFirestore
        .collection("posts")
        .where('salary', isGreaterThanOrEqualTo:
        queryString.toUpperCase()).getDocuments(); 
//List<DocumentSnapshot> documents=  new List<DocumentSnapshot>();

  
  }

  
//queryString).getDocuments();
}