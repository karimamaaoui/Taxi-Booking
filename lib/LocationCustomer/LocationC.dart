
import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'searchLocation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:taxi2/Assisants/assistantMethods.dart';
import 'package:taxi2/HamburgerMenu/Menu.dart';
import 'package:taxi2/MainScreen.dart';
import 'package:taxi2/Maps/listOfMaps.dart';
import 'package:taxi2/Widget/DividerWidget.dart';
import 'ConvertLocation.dart';
import 'package:taxi2/LocationCustomer/searchScreen.dart';

class LocationC extends StatefulWidget{

  @override
  _LocationCState  createState()=> _LocationCState ();

}

class _LocationCState extends State<LocationC>
{
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey:"AIzaSyCgNdI4otkEM7ONrqh2BbUQ8TTDIosMUhk" );

  Position currentPosition;
  var geoLocator=Geolocator();
  double bottomPaddingOfMap=0;
  Address addressC;
  Address addressMark;

  String addr1="";
  String addr2="";
  String addr3="";
  double distance;
  final LatLng _center = const LatLng(33.892166, 9.561555499999997);

  calculDistance()async
  {
    double dis=0;
    for (int i=0; i<MyPolylines.length;i++)
      {
         dis+= await Geolocator.distanceBetween(
            currentPosition.latitude, currentPosition.longitude,
            markpos.latitude, markpos.longitude);
        print(dis);

      }
    distance=dis;


  }

  getAddressbasedOnLocation() async
  {
    Position position=await Geolocator.getCurrentPosition(desiredAccuracy:LocationAccuracy.high);
    
    final coordinates= new Coordinates(position.latitude,position.longitude);
    var addresses =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    ConvertLocation().convertCoordinatesToAddress(coordinates).then((value) => addressC=value);


    setState(() {

      addr1=addresses.first.featureName;
      addr2=addresses.first.addressLine;
      print(addr1);

    });
    
  }
  Location location1;

  @override
  void initState()
  {
    super.initState();
    getAddressbasedOnLocation();
  }

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

  List<Marker> myMarker =[];
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng (33.892166,9.561555499999997),
    zoom: 14.4746,
  );
  GlobalKey <ScaffoldState> scaffoldKey=new GlobalKey<ScaffoldState>();

  LatLng markpos;

  String mark="";
  handleTap(LatLng tappedPoint) async
  {
    print(tappedPoint);

    final coordinates= new Coordinates(tappedPoint.latitude,tappedPoint.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    ConvertLocation().convertCoordinatesToAddress(coordinates).then((value) => addressMark=value);


    setState(() {
      myMarker=[];
      myMarker.add(
        Marker(markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        draggable: true,

        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        onDragEnd: (dragEndPosition)
            {
              print(dragEndPosition);
            }


        )
      );
      mark=addressMark.addressLine;
      markpos=tappedPoint;
      addPolyLine();
    });
  }

  List <Polyline> MyPolylines = [];
  PolylinePoints polylinePoints = PolylinePoints();

  List<LatLng> routeCoords=[];

  String googleAPiKey = "AIzaSyCgNdI4otkEM7ONrqh2BbUQ8TTDIosMUhk";

  addPolyLine()
  {
    MyPolylines.add(
      Polyline(
        polylineId: PolylineId('poly1'),
        color: Colors.red,

        width: 5,
        points: [LatLng(currentPosition.latitude, currentPosition.longitude),
                LatLng(markpos.latitude,markpos.longitude),
        ],

      )
    );

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
              GoogleMap(
                padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
                mapType: MapType.normal,
                  myLocationEnabled: true,
                  initialCameraPosition: _kGooglePlex ,
                  myLocationButtonEnabled: true,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  markers:
                  Set.from(myMarker),
                  onTap: handleTap,
                  polylines: MyPolylines.toSet(),
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
                      onBottomPressed(context);
                    }
                ),
            ),
        ),

      ]
        ),
      ),
  ),
);
  }
  void onBottomPressed(BuildContext context)
  {
    showModalBottomSheet(
        context: context,backgroundColor: Colors.transparent,
        builder: (context){
          return FittedBox(

            child: Container(

              child: Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: Container(
                    height: 300.0,
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
                          GestureDetector(


                              onTap: () {
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>searchScreen()));
                              },


                            child: Container(
                              width: 390,
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
                                      Text("Search Drop Off ${mark}")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0,),
                          Container(
                            width: 390,
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
                                    "Currently Place -   ${addr2} ",style: TextStyle(color:Colors.black54,fontSize: 12.0)
                                ),
                                SizedBox(width: 30.0,),

                              ],
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          DividerWidget(),
                          SizedBox(height: 16.0,),

                          Container(
                            width: 390,
                            decoration: BoxDecoration(
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
                    ),
                  )
              ),
            ),
          );
        });

  }

}