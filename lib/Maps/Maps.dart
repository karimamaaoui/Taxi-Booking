import 'dart:async';
import 'package:geocoder/geocoder.dart';
import 'package:taxi2/Assisants/assistantMethods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi2/MainScreen.dart';
import 'package:taxi2/Widget/DividerWidget.dart';
import '../LocationCustomer/ConvertLocation.dart';
import 'listOfMaps.dart';
import 'package:taxi2/HamburgerMenu/Menu.dart';

class Maps extends StatefulWidget {
  @override
  _MapseState createState() => _MapseState();
}

class _MapseState extends State<Maps> {

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;

  GlobalKey <ScaffoldState> scaffoldKey=new GlobalKey<ScaffoldState>();

  Position  currentPosition;
  var geoLocator =Geolocator();
  double bottomPaddingOfMap=0;
  Address _address;


List <Marker> _markers=[];

BitmapDescriptor userIcon;


  void locatePosition()async
  {
    Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    this.currentPosition=position;

    LatLng latLatPostion= LatLng(position.latitude,position.longitude);

    CameraPosition cameraPosition=new CameraPosition(target: latLatPostion,zoom: 14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    final coordinates= new Coordinates(position.latitude, position.longitude);
    ConvertLocation().convertCoordinatesToAddress(coordinates).then((value) => _address=value);
    var address= await AssistantMethods.getPlace(position,context);
    print("this is your address" + address );

  }


  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng (33.892166,9.561555499999997),
    zoom: 14.4746,
  );

  @override
  void initState()
  {
    super.initState();
    _markers.add(Marker(
      markerId: MarkerId('id1'),
      draggable: true,
      onTap: (){
        print('Marker Tapped');
      },
      position: LatLng (33.892166,9.561555499999997)
    ));

    /*
  @override
  void initState()
  {
    super.initState();
    _markers=Set.from([]);
  }*/

  /*createMarker(context)
  {
    if (userIcon ==null)
      {
        ImageConfiguration configuration=createLocalImageConfiguration(context);
        BitmapDescriptor.fromAssetImage
          (configuration, 'assets/marker.png')
            .then((icon) {
              setState(() {
                userIcon=icon;
              });
        });

      }

*/
  }
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
  /*              GoogleMap(

                  padding: EdgeInsets.only(bottom: this.bottomPaddingOfMap),
                  markers: Set.from(_markers),
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  initialCameraPosition: _kGooglePlex,
                  myLocationEnabled: true,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  /* onTap: (currentPosition) {
                    print(currentPosition);
                    Marker m =
                    Marker (markerId:MarkerId( '1'),icon:userIcon,
                        position: currentPosition );
                    setState(() {
                      _markers.add(m);
                    });
                  },*/
                  onMapCreated: (GoogleMapController controller )
                  {
                    _controllerGoogleMap.complete(controller);
                    this.newGoogleMapController=controller;

                    setState(() {
                      this.bottomPaddingOfMap=300.0;

                    });

                    locatePosition();

                  },

                ),*/
                //HamburgerButton fro Drawer
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
                        color: Colors.blueAccent,
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
                        backgroundColor: Colors.blueAccent,
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

                      /* height: 300.0,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255,238,120,1),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0),topRight:Radius.circular(18.0) ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 16.0,
                            spreadRadius: 0.5,
                            offset:Offset(0.7,0.7),

                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 6.0,),
                            Text("Hi there ",style: TextStyle(fontSize:14.0),),
                            Text("Where To ? ",style: TextStyle(fontSize:20.0 ,fontFamily: "Brand-Bold"),),
                            SizedBox(height: 20.0,),
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(249,184,187,1),
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 6.0,
                                    spreadRadius: 0.5,
                                    offset:Offset(0.7,0.7),

                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(Icons.search,color: Colors.black,),
                                      SizedBox(width: 10.0,),
                                      Text("Search Drop Off")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0,),
                            Container(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(253,235,197,1),
                                  borderRadius: BorderRadius.circular(5.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 6.0,
                                      spreadRadius: 0.5,
                                      offset:Offset(0.7,0.7),

                                    )
                                  ],

                                ),

                                child: Row(
                                children:[
                                  Icon(Icons.home, color: Colors.grey,),
                                  SizedBox(width: 12.0, ),
                                  Text(
                                        "Currently Place",style: TextStyle(color:Colors.black54,fontSize: 12.0)
                                  ),
                                  SizedBox(width: 30.0,),
                                  Text(" ${_address?.addressLine??  '-'}",style: TextStyle(color:Colors.black54,fontSize: 12.0),),

                                ],
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            DividerWidget(),
                            SizedBox(height: 16.0,),

                            Container(decoration: BoxDecoration(
                              color: Color.fromRGBO(205,236,169,1),
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 6.0,
                                  spreadRadius: 0.5,
                                  offset:Offset(0.7,0.7),

                                )
                              ],

                            ),

                              child: Row(
                                children: [
                                  Icon(Icons.work, ),
                                  SizedBox(width: 12.0,),
                                  Text("Add Work  "),
                                  SizedBox(height: 4.0,),
                                  Text("Your office adresse",style: TextStyle(color:Colors.black54,fontSize: 12.0),),

                                ],
                              ),
                            ),


                          ],

                        ),
                      ),*/

                    ),
                ),


              ],
            ),

          ),


    ),

    );
  }

}