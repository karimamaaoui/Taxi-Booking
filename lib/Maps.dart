import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:taxi2/MainScreen.dart';



class Maps extends StatefulWidget {
  @override
  _MapseState createState() => _MapseState();
}

class _MapseState extends State<Maps> {
  Position currentPosition;
  var geoLocator= Geolocator();
  void locatePosition()async
  {
    Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    this.currentPosition=position;
    LatLng latLatPosition=LatLng(position.latitude,position.longitude);
    //CameraPosition cameraPosition=new CameraPositon(target);
    
  }

  /*static final  CameraPosition _kGooglePlex= CameraPosition(
    target:
  )*/

  @override
  Widget build(BuildContext context) {
    void moveToTheLastScreen()
    {
      Navigator.pop(context);
    };
    return WillPopScope(
        onWillPop :(){
          moveToTheLastScreen();
        },

        child: Scaffold(
          appBar: AppBar(title: Text(''),
            backgroundColor: Color.fromRGBO(240, 160, 50, 1.0),
            leading: IconButton(icon: Icon(Icons.arrow_back),
                onPressed: (){moveToTheLastScreen();}
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),
                          (route) => false);
                },
              )
            ],
          ),

    )
    );
  }

}