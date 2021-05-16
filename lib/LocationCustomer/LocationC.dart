import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi2/Assisants/assistantMethods.dart';
import 'package:taxi2/HamburgerMenu/Menu.dart';
import 'package:taxi2/MainScreen.dart';
import 'package:taxi2/Maps/listOfMaps.dart';
import 'ConvertLocation.dart';
class LocationC extends StatefulWidget{

  @override
  _LocationCState  createState()=> _LocationCState ();


}

class _LocationCState extends State<LocationC>
{
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;

  Position currentPosition;
  var geoLocator=Geolocator();
  double bottomPaddingOfMap=0;
  Address addressC;


  void locatePosition ()async{
    Position position=await Geolocator.getCurrentPosition(desiredAccuracy:LocationAccuracy.high);
    currentPosition=position;

    LatLng latLngPosition=LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =new CameraPosition(target: latLngPosition,zoom:14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    final coordinates= new Coordinates(position.latitude, position.longitude);
    ConvertLocation().convertCoordinatesToAddress(coordinates).then((value) => addressC=value);
    var address= await AssistantMethods.getPlace(position,context);
    print("this is your address ${addressC} " );




  }


  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng (33.892166,9.561555499999997),
    zoom: 14.4746,
  );
  GlobalKey <ScaffoldState> scaffoldKey=new GlobalKey<ScaffoldState>();



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
          key: this.scaffoldKey,
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
          drawer: Container(
            child: Menu(),
          ),

      body: Container(
        child: Stack(
            children: [
              GoogleMap(
                padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
                mapType: MapType.normal,
                  myLocationEnabled: true,
                  initialCameraPosition: _kGooglePlex ,
                  myLocationButtonEnabled: true,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  onMapCreated: (GoogleMapController controller)
                  {

                    _controllerGoogleMap.complete(controller);
                    newGoogleMapController=controller;
                    setState(() {
                      bottomPaddingOfMap=265.0;
                    });
                    locatePosition();
                  },
            ),

              Positioned(
                top: 45.0,
                left: 22.0,
                child: GestureDetector(
                  onTap: ()
                  {
                    this.scaffoldKey.currentState.openDrawer();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 6.0,
                            spreadRadius: 0.5,
                            offset: Offset(
                              0.7,
                              0.7,

                            ),
                          ),
                        ]
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.menu,color: Colors.black,),
                      radius: 20.0,
                    ),
                  ),
                ),
              ),

            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                child: RaisedButton(
                    child: Text("Show",style: TextStyle(fontSize: 20),),
                    onPressed: (){
                      listOfMaps().onBottomPressed(context);
                    }
                ),
            ),
        ),

      ]
        ),
      ),
  )
);
  }

}