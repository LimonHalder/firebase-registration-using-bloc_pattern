
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SearchEvent extends Equatable {}

/*class Search extends SearchEvent {
 dynamic query;

  Search({@required this.query});

  @override
  List<Object> get props => [];
}*/

class ButtonPressed extends SearchEvent {
//String query;
  final String search;

ButtonPressed({@required this.search});
  @override
  List<Object> get props => [];
}

class SearchChanged extends SearchEvent {
  final String search;

  SearchChanged({this.search});

  @override
  List<Object> get props => [search];
}

class SearchPressed extends SearchEvent {
  final String search;

  SearchPressed({this.search});

  @override
  List<Object> get props => [search];
}