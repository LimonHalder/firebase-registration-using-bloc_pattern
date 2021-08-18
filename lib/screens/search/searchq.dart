import 'dart:async';

import 'package:firebase_registration_using_bloc/profilepage.dart';
import 'package:firebase_registration_using_bloc/search/search_bloc.dart';
import 'package:firebase_registration_using_bloc/search/search_event.dart';
import 'package:firebase_registration_using_bloc/search/search_state2.dart';
import 'package:firebase_registration_using_bloc/validatore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapGeoLocatorPage extends StatefulWidget {
  @override
  _MyGeoLocatorPageState createState() => _MyGeoLocatorPageState();
}

class _MyGeoLocatorPageState extends State<MapGeoLocatorPage> {
  Completer<GoogleMapController> _mapController = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  //static LatLng _initialPosition;
  //Set<Marker> markers = {};
  TextEditingController _searchController = TextEditingController();
  //MapBloc _mapBloc;
  SearchBloc _searchBloc;
  bool get isPopulated => _searchController.text.isNotEmpty;

  bool isSearchEnabled(SearchState state) {
    return isPopulated;
  }

  @override
  void initState() {
    super.initState();
    // _getUserLocation();
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    /*WidgetsBinding.instance.addPostFrameCallback((_){
    _searchBloc.add(
      //MapOnLoadEvent()
      SearchPressed()
      
      );
      _searchBloc.add(
      //MapOnLoadEvent()
      ButtonPressed()
      
      );
      });*/
  }

  /*void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    /* setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });*/
  } */

  /*Future<ui.Image> loadUiImage(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final list = Uint8List.view(data.buffer);
    final completer = Completer<ui.Image>();
    ui.decodeImageFromList(list, completer.complete);
    return completer.future;
  }*/

  /*Future<Uint8List> getBytesFromCanvas(String text) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.red;
    final int size = 250; //change this according to your app
    canvas.drawImage(await loadUiImage("assets/images/marker.png"),
        Offset(size / 2, size / 2), paint1);
    //canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: text, //you can write your own text here or take from parameter
      style: TextStyle(
          fontSize: size / 7, color: Colors.red, fontWeight: FontWeight.bold),
    );
    painter.layout();
    painter.paint(
      canvas,
      Offset(size / 2 - painter.width / 6, size / 2 - painter.height),
    );

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data.buffer.asUint8List();
  }*/

  _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  /* Future<void> _addMarker(
   // String markerId, LatLng latLongi, String title, String money, String address, String time
    
    ) async {
    final Uint8List desiredMarker = await getBytesFromCanvas(money);

    setState(() {
      myMarkers.add(
        Marker(
            markerId: MarkerId(markerId),
            position: latLongi,
            infoWindow: InfoWindow(
              title: title,
            ),
            icon: BitmapDescriptor.fromBytes(desiredMarker),
            onTap: () {
              _showBottomSheet(context, title, money, address, time, latLongi);
            }),
      );
    });
  }*/

  Future<void> initMarker(tomb, tombId) async {
    var markerIdVal = tombId;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = new Marker(
      markerId: markerId,
      position: LatLng(tomb['location1'].latitude, tomb['location1'].latitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      infoWindow: InfoWindow(
        title: tomb['salary'],
      ),
    );
    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
    ;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void back() {
    Navigator.pop(context);
  }

  //void confirmPage(BuildContext context, String name, String address,
  //  LatLng latLongi, String money) {
  /// Navigator.push(
  // context,
  // MaterialPageRoute(
  //  builder: (context) => ConfirmPharmacyPage(
  //    name: name,
  //   address: address,
  //   latLng: latLongi,
  //   money: money,
  // ),
  ///  ));
  // }

  /*_showBottomSheet(context, String name, String money, String address,
      String time, LatLng latLongi) {
    showModalBottomSheet<void>(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        ),
        backgroundColor: bottom_sheet_bgColor,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            decoration: BoxDecoration(color: bottom_sheet_bgColor),
            child: new Column(
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                  width: 1.0,
                ),
                Padding(
                  padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 3.0),
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: bottom_sheet_nameText,
                  ),
                ),
                Padding(
                  padding: new EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        MapPageStrings.address,
                        style: bottom_sheet_addressText,
                      ),
                      Text(
                        address,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        style: bottom_sheet_addressValue,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: new EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        MapPageStrings.open,
                        style: bottom_sheet_openText,
                      ),
                      Text(
                        time,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        style: bottom_sheet_openValue,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: new EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        MapPageStrings.rate,
                        style: bottom_sheet_rateText,
                      ),
                      Text(
                        money + " taka",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        style: bottom_sheet_rateValue,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                FlatButton(
                  color: select_pharmacy_buttonColor,
                  textColor: select_pharmacy_button_textColor,
                  padding: EdgeInsets.all(12.0),
                  onPressed: () {
                    confirmPage(context, name, address, latLongi, money);
                  },
                  child: Text(
                    MapPageStrings.select_pharmacy_btn,
                    style: select_pharmacy_buttonText,
                  ),
                ),
              ],
            ),
          );
        });
  }*/

  Widget _buildChild(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {},
      child: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
        //if (state.geocode.length > 0) {
        //List<GeoCode> geoCodeList = state.geocode;
        // for (int i = 0; i < geoCodeList.length; i++) {
        //  GeoCode geoCode = geoCodeList[i];
        // GeoCode geocodeTarget = geoCodeList[0];
        //  var latLongi = LatLng(geoCode.x, geoCode.y);
        // _initialPosition = LatLng(geocodeTarget.x, geocodeTarget.y);
        //_addMarker(geoCode.name, latLongi, geoCode.name,
        //   geoCode.money.toString(), geoCode.address, geoCode.time);
        // }

        // return GoogleMap(
        //onMapCreated: _onMapCreated,
        /// initialCameraPosition: CameraPosition(
        // bearing: 270,
        // target: _initialPosition,
        // tilt: 30.0,
        //   zoom: 10.0,
        // ),
        //  markers: myMarkers,
        //);
        // } else {
        // return Center(
        //  child: CircularProgressIndicator(),
        //);
        //}
        // }
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
            padding: const EdgeInsets.symmetric(vertical: 59),
            child: Stack(
              children: [
                ListView.builder(
                    itemCount: state.snapshot.documents.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                      post: state.snapshot.documents[index],
                                    ))),
                        title: Card(
                          elevation: 5,
                          child: Container(
                            height: 135,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: new Image.asset(
                                    'assets/cardimg.jpg',
                                    width: 60.0,
                                    height: 80.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(6),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "${state.snapshot.documents[index].data["name"]}",
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            color: Colors.indigo),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Expert in ${state.snapshot.documents[index].data["salary"]}",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Text(
                                        "${state.snapshot.documents[index].data["fee"]}tk",
                                        style: TextStyle(
                                            fontSize: 23,
                                            color: Colors.blueGrey),
                                      ),
                                    ],
                                  ),
                                ),
                                /* Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Text(
                                              "${snapshot.data[index].data["fee"]}tk",
                                              style: TextStyle(fontSize: 25),
                                            ),
                                          )
                                        ],
                                      ),
                                    )*/
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(height: 20),
                Positioned(
                    bottom: 35.0,
                    right: 5.0,
                    child: FloatingActionButton(
                        backgroundColor: Colors.black45,
                        onPressed: () {
                          // Navigator.push(context,
                          // MaterialPageRoute(builder: (context) => NewMap()));
                          //searchBloc.add(ButtonPressed(query: query));
                          // _searchBloc.add(ButtonPressed(search: search));
                          // _onSearchChanged();
                          if (isSearchEnabled(state)) {
                            _onMapSubmitted();
                          }
                        },
                        child: Icon(
                          FontAwesomeIcons.map,
                          size: 50, //Icon Size
                          color: Colors.white,
                          //Color Of Icon
                        ))),
              ],
            ),
          );
        }
        if (state is ShowMap) {
          //Navigator.pop(context);
          if (state.snapshot.documents.isNotEmpty) {
            for (int i = 0; i < state.snapshot.documents.length; ++i) {
              initMarker(state.snapshot.documents[i].data,
                  state.snapshot.documents[i].documentID);
              //var markers =state.snapshot.documents[i].data;
            }

            return GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: CameraPosition(
                  target: LatLng(41.3, -70.98),
                  zoom: 12,
                ),
                onMapCreated: (GoogleMapController controller) {
                  controller = controller;
                },
                compassEnabled: true,
                myLocationEnabled: true,
                markers: //markers.values
                    Set<Marker>.of(markers.values));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // ignore: missing_return
        onWillPop: () {
          back();
        },
        child: Scaffold(
          body: BlocListener<SearchBloc, SearchState>(
            listener: (context, state) {
              if (state is SearchError) {
                Scaffold.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Failure'),
                        Icon(Icons.error),
                      ],
                    ),
                    backgroundColor: Color(0xffffae88),
                  ));
              }

              /*if (state is SearchUninitialized) {
                Scaffold.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Searching.....'),
                        CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      ],
                    ),
                    backgroundColor: Color(0xffffae88),
                  ));
              }*/

              /*if (state.isSuccess) {
                Scaffold.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    CustomSnackBar(
                        snackBarMessage: MapPageStrings.searchSuccess,
                        icon: Icons.check),
                  );
              }*/
            },
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Stack(
                    children: <Widget>[
                      
                        _buildChild(context),
                      
                      Positioned(
                        top: 35.0,
                        left: 5.0,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            back();
                          },
                          iconSize: 40.0,
                        ),
                      ),
                      Positioned(
                        top: 30.0,
                        right: 40.0,
                        left: 50.0,
                        child: Container(
                          height: 55.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.blueGrey),
                          child: TextFormField(
                            controller: _searchController,
                            decoration: InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.only(left: 15.0, top: 15.0),
                                suffixIcon: IconButton(
                                    icon: Icon(Icons.search),
                                    onPressed: () {
                                      //_onSearchChanged();
                                      if (isSearchEnabled(state)) {
                                        _onSearchSubmitted();
                                      }
                                    },
                                    iconSize: 30.0)),
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }

  //void _onSearchChanged() {
  // _searchBloc.add(SearchChanged(search: _searchController.text));
  //}

  void _onSearchSubmitted() {
    _searchBloc.add(SearchPressed(search: _searchController.text));
  }

  void _onMapSubmitted() {
    _searchBloc.add(ButtonPressed(search: _searchController.text));
  }
}
