import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_registration_using_bloc/profilepage.dart';
import 'package:firebase_registration_using_bloc/register_bloc/register_bloc.dart';
import 'package:firebase_registration_using_bloc/register_bloc/register_state.dart';
import 'package:firebase_registration_using_bloc/screens/search/search.dart';
import 'package:firebase_registration_using_bloc/screens/search/searchq.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication_bloc/authentication_event.dart';
import 'authentication_bloc/authentication_state.dart';
import 'authentication_bloc/authentrication_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseUser user;

  const HomeScreen({Key key, this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
          toolbarHeight: 100,
            title: Text('DOCsrc'),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => MapGeoLocatorPage()));
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(AuthenticationLoggedOut());
                },
              )
            ],
          ),
        
        body: ListPage());
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future getpost() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("posts").getDocuments();
    return qn.documents;
  }

  navigateToDetails(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailsPage(
                  post: post,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: getpost(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text("loading"));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                          onTap: () => navigateToDetails(snapshot.data[index]),
                          title: Card(
                            elevation: 5,
                            child: Container(
                              height: 135,
                              child: Row(
                                mainAxisAlignment:
                                      MainAxisAlignment.start,
                                
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
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 8,),
                                          Text(
                                            "${snapshot.data[index].data["name"]}",
                                            style: TextStyle(
                                                fontSize: 22.0,
                                                color: Colors.indigo),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Expert in ${snapshot.data[index].data["salary"]}",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "${snapshot.data[index].data["fee"]}tk",
                                              style: TextStyle(fontSize: 23,
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
                    });
              }
            }));
  }
}


  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
   //Container(
     // child: Card(
            //child: ListTile(
         // title: Text(widget.post.data["name"]),
          //subtitle: Text(widget.post.data["location"]),
      
            //)),
    //);  