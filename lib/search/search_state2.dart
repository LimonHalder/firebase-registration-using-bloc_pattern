import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SearchState extends Equatable {}

class SearchUninitialized extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
  // List<Recipe> recipes;
  final List<DocumentSnapshot> documents;
  final QuerySnapshot snapshot;
  SearchLoaded({@required this.documents, @required this.snapshot});
  @override
  List<Object> get props => [];
}

class SearchError extends SearchState {
  @override
  List<Object> get props => [];
}

class ShowMap extends SearchState {
 final List<DocumentSnapshot> documents;
  final QuerySnapshot snapshot;
  ShowMap({@required this.documents, @required this.snapshot});
  @override
  List<Object> get props => [];
}
