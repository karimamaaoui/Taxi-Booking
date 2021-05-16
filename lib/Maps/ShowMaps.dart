import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowMaps extends StatefulWidget {
  @override
  _MapsShowState createState() => _MapsShowState();
}

class _MapsShowState extends State<ShowMaps> {

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState>scaffoldKey= new GlobalKey<ScaffoldState>();
  Position currentPosition ;
  var geoLocator=Geolocator();
  double bottomPaddingOfMap=0;

  void locatePositon()async{
    Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition=position;
    LatLng latLatPostion= LatLng(position.latitude,position.longitude);

    CameraPosition cameraPosition=new CameraPosition(target: latLatPostion,zoom: 14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));



  }


  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng (33.892166,9.561555499999997),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text("Location Services"),

          ),
      body: Container(

            child: Stack(
            children: [
              GoogleMap(
                  padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  initialCameraPosition: _kGooglePlex,
                  myLocationEnabled: true,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,

                      onMapCreated: (GoogleMapController controller )
                  {
                    _controllerGoogleMap.complete(controller);
                    this.newGoogleMapController=controller;
                    setState(() {
                      bottomPaddingOfMap=265.5;
                    });

                    locatePositon();

                  },

                ),

      ],
        )
      )
    );
  }

}