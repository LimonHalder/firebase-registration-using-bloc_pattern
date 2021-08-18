import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_registration_using_bloc/search/search_bloc.dart';
import 'package:firebase_registration_using_bloc/search/search_event.dart';
import 'package:firebase_registration_using_bloc/search/search_state2.dart';
//import 'package:firebase_registration_using_bloc/search/search_state2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewMap extends StatefulWidget {
  @override
  _NewMapState createState() => _NewMapState();
}

class _NewMapState extends State<NewMap> {
  GoogleMapController _controller;

  Widget _child;
 SearchBloc searchBloc;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  BitmapDescriptor pinLocationIcon;

  @override
  void initState() {
    searchBloc = BlocProvider.of<SearchBloc>(context);
    searchBloc.add(ButtonPressed());
    setCustomMapPin();
    super.initState();
  }

  

  void initMarker(tomb, tombId) {
    var markerIdVal = tombId;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
          tomb.data()['location'].latitude, tomb.data()['location'].latitude),
      icon: pinLocationIcon,
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/pin.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffffb838)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (BuildContext context, SearchState state) {
          if (state is ShowMap) {
            if (state.snapshot.documents.isNotEmpty) {
              for (int i = 0; i < state.snapshot.documents.length; ++i) {
                initMarker(state.snapshot.documents[i].data,
                    state.snapshot.documents[i].documentID);
              }
            }
            return _child;
          }
          return _child;
        },
      ),
    );
  }

  Widget mapWidget() {
    return Stack(
      children: <Widget>[
        GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(45, 75.6),
              zoom: 10,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            compassEnabled: true,
            myLocationEnabled: true,
            markers: Set<Marker>.of(markers.values)),
        SizedBox(
          height: 26,
        ),
      ],
    );
  }
}
