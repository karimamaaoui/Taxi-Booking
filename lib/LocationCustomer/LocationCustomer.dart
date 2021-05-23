import 'dart:async';/*
import 'package:flutter_map/flutter_map.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong/latlong.dart';
import 'package:taxi2/HamburgerMenu/Menu.dart';
import 'package:taxi2/MainScreen.dart';
import 'package:taxi2/Widget/DividerWidget.dart';

class LocationCustomer extends StatefulWidget{

  @override
  _LocationCustomerState  createState()=> _LocationCustomerState ();

}

class _LocationCustomerState extends State<LocationCustomer>
{
  /*MapController controller = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude:   33.892166, longitude: 9.561555499999997),
  );
*/
  /*GlobalKey <ScaffoldState> scaffoldKey=new GlobalKey<ScaffoldState>();
  getMyLocation()async
  {

    try {
      GeoPoint p = await controller.myLocation();


      double lat=p.latitude;
      double lon=p.longitude;
      print(  "latitude is :$lat,  longitude is:$lon");
    } on GeoPointException catch (e) {
      print( "${e.errorMessage()}");
    }
  }*/
double long =33.892166;
double lat=9.561555499999997;
var location =[];
LatLng point = LatLng(33.892166, 9.561555499999997);

  @override
    Widget build(BuildContext context) {
      return Stack(

        children: [new FlutterMap(
          options: new MapOptions(
           // center: new LatLng(33.892166, 9.561555499999997),
            //zoom: 13.0,
            onTap: (p) async{
              location=await Geocoder.local.findAddressesFromCoordinates(new Coordinates(p.latitude, p.longitude));
              setState(() {
                point = p;
                print(p);
              });

              print(
                  "${location.first.countryName} - ${location.first.featureName}");
              },
              center: new LatLng(33.892166, 9.561555499999997),
              zoom: 13.0,

          ),
          layers: [
            new TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']
            ),
            new MarkerLayerOptions(
              markers: [
                new Marker(
                  width: 30.0,
                  height: 30.0,
                  point: point,
                  builder: (ctx) =>
                  new Container(
                    child:  Icon(Icons.location_on),
                    color:Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 34.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16.0),
                      hintText: "Search for your localisation",
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                            "${location.first.countryName},${location.first.locality}, ${location.first.featureName}"),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ]
      );
    }
}
//flutter_map: ^0.12.0*/
