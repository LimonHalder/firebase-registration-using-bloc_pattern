/*import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_registration_using_bloc/profilepage.dart';
import 'package:firebase_registration_using_bloc/search/search_bloc.dart';
import 'package:firebase_registration_using_bloc/search/search_event.dart';
import 'package:firebase_registration_using_bloc/search/search_state2.dart';
//import 'package:firebase_registration_using_bloc/search/search_state2.dart';
import 'package:firebase_registration_using_bloc/verifybloc/lio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // FoodBloc foodBloc;

  @override
  void initState() {
    //foodBloc = BlocProvider.of<FoodBloc>(context);
    //foodBloc.add(FetchFoodEvent());
    //searcBloc.add(TextChanged(query: ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: FoodSearch(
                        searchBloc: BlocProvider.of<SearchBloc>(context)));
              }),
          IconButton(icon: Icon(Icons.person), onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            //child: BlocBuilder<FoodBloc, FoodState>(builder: (context, state) {
            // if (state is FoodInitialState) {
            //  return buildLoading();
            //} else if (state is FoodLoadingState) {
            //   return buildLoading();
            // } else if (state is FoodLoadedState) {
            //  return buildHintsList(state.recipes);
            // } else if (state is FoodErrorState) {
            //  return buildError(state.message);
            // }
            //}),
            ),
      ),
    );
  }
}

  class FoodSearch extends SearchDelegate<List> {
   Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  SearchBloc searchBloc;
  FoodSearch({@required this.searchBloc});
  QuerySnapshot snapshot;

 
  //List<DocumentSnapshot> documents;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    GoogleMapController controller;
 Set<Marker> _markers2 = {};
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

    final snapshot = query;
    List<GeoPoint> geopoint;
    List<DocumentSnapshot> documents;
    searchBloc.add(Search(query: query));
    searchBloc = BlocProvider.of<SearchBloc>(context);
    return BlocBuilder<SearchBloc, SearchState>(
        builder: (BuildContext context, SearchState state) {
          if (state is SearchUninitialized) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is SearchError) {
            return Center(
              child: Text('Failed To Load'),
            );
          }
          if (state is SearchLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  ListView.builder(
                      itemCount: state.snapshot.documents.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsPage(
                                          post:
                                              state.snapshot.documents[index])));
                            },
                            title: Card(
                              elevation: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(Icons.person),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.snapshot.documents[index]
                                              .data['name'],
                                          style: TextStyle(
                                              fontSize: 22.0,
                                              color: Colors.deepOrangeAccent),
                                        ),
                                        Text(
                                          state.snapshot.documents[index]
                                              .data['salary'],
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Fees ",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                        Text(state.snapshot.documents[index]
                                            .data['fee'])
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ));
                      }),
                  SizedBox(height: 20),
                  FloatingActionButton(
                      backgroundColor: Colors.green,
                      onPressed: () {
                       // Navigator.push(context,
                           // MaterialPageRoute(builder: (context) => NewMap()));
                        //searchBloc.add(ButtonPressed(query: query));
                        //searchBloc.add(ButtonPressed(query: query));
                      },
                      child: Icon(
                        FontAwesomeIcons.whatsapp,
                        size: 50, //Icon Size
                        color: Colors.white,
                        //Color Of Icon
                      ))
                ],
              ),
            );
          }
          if (state is ShowMap) {
            if (state.snapshot.documents.isNotEmpty) {
              for (int i = 0; i < state.snapshot.documents.length; ++i) {
                initMarker(state.snapshot.documents[i].data,
                    state.snapshot.documents[i].documentID);
                    //var markers =state.snapshot.documents[i].data;
              }
            
               return Center(
              child: Stack(
                children: <Widget>[
                  GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(45, -75.6),
                        zoom: 10,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        controller = controller;
                      },
                      compassEnabled: true,
                      myLocationEnabled: true,
                      markers: Set<Marker>.of(markers.values)),
                 
                ],
                ),
            
            
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
          }
          
    );
          
        
    
    
    
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

 Future<void> initMarker(tomb, tombId) async {
    var markerIdVal = tombId;
    final MarkerId markerId = MarkerId(markerIdVal);
  
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
          tomb['location1'].latitude, tomb['location1'].latitude),
      icon: BitmapDescriptor.defaultMarker,
    );
      //setState(() {
      // adding a new marker to map
    // markers[markerId] = marker;
    //});
     ;
       
  }
 
}*/
