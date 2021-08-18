

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_registration_using_bloc/repositories/search_repository.dart';
import 'package:firebase_registration_using_bloc/search/search_event.dart';
import 'package:firebase_registration_using_bloc/search/search_state2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
   SearchRepository searchRepository;
  SearchBloc({@required this.searchRepository}) : super(null);
//SearchBloc({SearchRepository searchRepository})
  // :// _serachRepository = searchRepository,
  //  super(null);
  SearchState get initialState => SearchUninitialized();
  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
   if(event is SearchPressed){
     yield SearchUninitialized();
     try {
       QuerySnapshot snapshot = await searchRepository.queryData(event.search);
       yield SearchLoaded( snapshot: snapshot, documents: []);



     } catch (e) {
       yield SearchError();
     }
   }
if(event is ButtonPressed){
     yield SearchUninitialized();
     try {
       QuerySnapshot snapshot = await searchRepository.queryData(event.search);
       yield ShowMap( snapshot: snapshot, documents: []);
       


     } catch (e) {
      yield SearchError();
     }
   }

  }}