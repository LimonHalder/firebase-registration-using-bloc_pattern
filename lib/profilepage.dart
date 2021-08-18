import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailsPage extends StatefulWidget {
  final DocumentSnapshot post;

  //DetailsPage({this.post,this.user});

  const DetailsPage({
    Key key,
    this.post,
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  void launchWhatsapp({@required number, @required message}) async {
    String url = "whatsapp://send?phone=$number&text=$message";
    await canLaunch(url) ? launch(url) : print("error");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: _appbar(),
      body: _profilePage(),
    );
  }

  Widget _appbar() {
    return AppBar(
      backgroundColor: Colors.blueGrey[400],
      title: Text(
        "Profile",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget _profilePage() {
    return SingleChildScrollView(
      child: SafeArea(
          child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            _avater(),
            SizedBox(
              height: 6,
            ),
            _usernameTile(),
            SizedBox(
              height: 30,
            ),
            _descriptionTile(),
            SizedBox(
              height: 30,
            ),
            _usercontactTile(),
            _useremailTile(),
            _userphoneTile(),
            _userwhatsapp(),
          ],
        ),
      )),
    );
  }

  Widget _avater() {
    return 
    //CircleAvatar(
     // radius: 50,
      //child:
       new Image.asset(
        'assets/doctor-bulk.png',
        width: 140.0,
        height: 110.0,
        fit: BoxFit.fill,
    //  ),
      //backgroundColor: Colors.lightGreen[200],
      //foregroundColor: Colors.limeAccent,
    );
  }

  Widget _userprofile() {
    return Center(
      child: Text(
        "Profile",
        style: TextStyle(),
      ),
    );
  }

  Widget _usernameTile() {
    return Center(
      child: ListTile(
        title: Center(
            child: Text(
          widget.post.data["name"],
          style: TextStyle(fontSize: 25, color: Colors.white),
        )),
        subtitle: Center(
          child: Text(
            widget.post.data["salary"],
            style: TextStyle(fontSize: 16.0, color: Colors.white60),
          ),
        ),
      ),
    );
  }

  Widget _descriptionTile() {
    return ListTile(
      tileColor: Colors.blueGrey[700],
      subtitle: Text(
        widget.post.data["location"],
        style: TextStyle(fontSize: 16, color: Colors.white70),
      ),
      title: Text(
        "A B O U T  M E",
        style: TextStyle(fontSize: 20, color: Colors.white54),
      ),
    );
  }

  Widget _useremailTile() {
    return ListTile(
      tileColor: Colors.blueGrey[700],
      title: Center(
          child: Text(
        widget.post.data["email"],
        style: TextStyle(fontSize: 16, color: Colors.white70),
      )),
    );
  }

  Widget _useremaiTile() {
    return ListTile(
      tileColor: Colors.white,
      subtitle: Text(widget.post.data["location"]),
      title: Text("ABOUT ME"),
    );
  }

  Widget _usercontactTile() {
    return ListTile(
      title: Center(
          child: Text(
        "C O N T A C T  M E",
        style: TextStyle(fontSize: 20, color: Colors.white70),
      )),
    );
  }

  Widget _userphoneTile() {
    return ListTile(
      tileColor: Colors.blueGrey[700],
      title: Center(
          child: Text(
        widget.post.data["phone"],
        style: TextStyle(fontSize: 16, color: Colors.white70),
      )),
    );
  }

  Widget _userwhatsapp() {
    return Center(
        child: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {
              launchWhatsapp(
                  number: widget.post.data["phone"], message: "Hello!");
            },
            child: Icon(
              FontAwesomeIcons.whatsapp,
              size: 50, //Icon Size
              color: Colors.white,
              //Color Of Icon
            )));
  }
}
