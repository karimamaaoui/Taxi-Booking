
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:taxi2/Assisants/assistantMethods.dart';
import 'package:taxi2/MainScreen.dart';
import 'package:taxi2/Widget/DividerWidget.dart';
import 'package:taxi2/splash_screen/enbording_page.dart';
import 'ConvertLocation.dart';
import 'package:taxi2/LocationCustomer/searchScreen.dart';
import 'package:taxi2/HamburgerMenu/MenuC.dart';

class LocationC extends StatefulWidget{

  @override
  _LocationCState  createState()=> _LocationCState ();
    LocationC({currentPosition,markpos,price});
}

class _LocationCState extends State<LocationC>
{

  DatabaseReference rideRequestRef;


   void saveRequest()
  {
    rideRequestRef=FirebaseDatabase.instance.reference().child("Ride Requests").push();

    Map pickUpLocMap =
    {
      "latitude":currentPosition.latitude.toString(),
      "longitude":currentPosition.longitude.toString(),

    };

    Map dropOffLocMap =
    {
      "latitude":markpos.latitude.toString(),
      "longitude":markpos.longitude.toString(),

    };

    Map rideInfo={
      "driver_id":"waiting",
      "payment_method" :"cash",
      "pickup":pickUpLocMap,
      "dropOf":dropOffLocMap,
      "created_at":DateTime.now().toString(),
      "ride_email":email,

    };

    rideRequestRef.set(rideInfo);

  }

  void cancelRequest()
  {
    rideRequestRef.remove();
  }



  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey:"AIzaSyCgNdI4otkEM7ONrqh2BbUQ8TTDIosMUhk" );
String idx;
  String price;
  Position currentPosition;
  var geoLocator=Geolocator();
  double bottomPaddingOfMap=0;
  Address addressC;
  Address addressMark;
String dvEmail;
  String uid;
  String email;
  String addr1="";
  String addr2="";
  String addr3="";
  double distance;
  final LatLng _center = const LatLng(33.892166, 9.561555499999997);

  get size => 18;

  var locationDistance;

  calculDistance()async
  {
    double distanceInMeters = await Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      markpos.latitude,
      markpos.longitude
    );
    var kilo=distanceInMeters/1000;
  print(distanceInMeters);
  print(kilo);
  print(currentPosition.toString());
  print(markpos.toString());
  distance=distanceInMeters;
  print(distance);

  if(distanceInMeters <=300)
    {
      price="TND 2500";

    }
  else
  if(distanceInMeters>300 && distanceInMeters<=600)
    {
      price="TND 3000";
    }

    else if(distanceInMeters>600 && distanceInMeters<=1000 )
      {
        price="TND 4000";

      }
  else if(distanceInMeters>1000 && distanceInMeters<=3000)
  {
    price="TND 6000";

  }

  else if( distanceInMeters>3000 && distanceInMeters<=6000)
  {
    price="TND 10000";

  }
  else if(distanceInMeters>6000 && distanceInMeters<9000)
  {
    price="TND 12000";

  }

  else if(distanceInMeters>9000 && distanceInMeters<=12000)
  {
    price="TND 16000";

  }

  else if(distanceInMeters>12000 && distanceInMeters<=20000)
  {
    price="TND 20000";

  }

  else if(distanceInMeters>20000 && distanceInMeters<=23500)
  {
    price="TND 24000";

  }
  else{
    price="TND 28000";
  }

    print(price);
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
    uid = FirebaseAuth.instance.currentUser.uid;
    email = FirebaseAuth.instance.currentUser.email;

    print(uid);
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
  Location  place;
  String mark="";
  BitmapDescriptor pinLocationIcon;

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


        ),
          );
      myMarker.add(

          Marker(
              markerId:MarkerId('id1'),
              position:LatLng( currentPosition.latitude,currentPosition.longitude),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),

      ),);

      BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 3.5, ),
          'assets/images/taximark.ico',).then((onValue) {
        pinLocationIcon = onValue;
      });
      myMarker.add(
        Marker(
         markerId:MarkerId('car1'),
          position:LatLng(36.805299,10.170632),
          icon:pinLocationIcon,
        )
      );
      myMarker.add(
          Marker(
            markerId:MarkerId('car2'),
            position:LatLng(36.802412,10.175117),
            icon:pinLocationIcon,

          )
      );

      myMarker.add(
          Marker(
            markerId:MarkerId('car3'),
            position:LatLng(36.814507,10.189202),
            icon:pinLocationIcon,

          )
      );
      myMarker.add(
          Marker(
            markerId:MarkerId('car4'),
            position:LatLng(36.757591,10.280833),
            icon:pinLocationIcon,

          )
      );
      myMarker.add(
          Marker(
            markerId:MarkerId('car5'),
            position:LatLng(36.737784,10.260092),
            icon:pinLocationIcon,

          )
      );
      myMarker.add(
          Marker(
            markerId:MarkerId('car6'),
            position:LatLng(36.736133,10.307502),
            icon:pinLocationIcon,

          )
      );
      myMarker.add(
          Marker(
            markerId:MarkerId('car7'),
            position:LatLng(36.727328,10.342544),
            icon:pinLocationIcon,

          )
      );

      myMarker.add(
          Marker(
            markerId:MarkerId('car8'),
            position:LatLng(36.708064,10.374838),
            icon:pinLocationIcon,

          )
      );


      myMarker.add(
          Marker(
            markerId:MarkerId('car9'),
            position:LatLng(36.727328,10.342544),
            icon:pinLocationIcon,

          )
      );


      myMarker.add(
          Marker(
            markerId:MarkerId('car10'),
            position:LatLng(36.694851,10.166646),
            icon:pinLocationIcon,

          )
      );


      myMarker.add(
          Marker(
            markerId:MarkerId('car11'),
            position:LatLng(36.673926,10.151529),
            icon:pinLocationIcon,

          )
      );

      myMarker.add(
          Marker(
            markerId:MarkerId('car12'),
            position:LatLng(36.801210,10.176002),
            icon:pinLocationIcon,

          )
      );


      myMarker.add(
          Marker(
            markerId:MarkerId('car13'),
            position:LatLng(36.795711,10.175959),
            icon:pinLocationIcon,

          )
      );


      myMarker.add(
      Marker(
        markerId:MarkerId('car14'),
        position:LatLng(36.799140,10.175260),
        icon:pinLocationIcon,

      )
      );

      myMarker.add(
          Marker(
            markerId:MarkerId('car15'),
            position:LatLng(36.752020,10.265607),
            icon:pinLocationIcon,

          )
      );

      myMarker.add(
          Marker(
            markerId:MarkerId('car16'),
            position:LatLng(36.765636,10.260626),
            icon:pinLocationIcon,

          )
      );

      myMarker.add(
          Marker(
            markerId:MarkerId('car17'),
            position:LatLng(36.763126,10.266619),
            icon:pinLocationIcon,

          )
      );

      myMarker.add(
          Marker(
            markerId:MarkerId('car18'),
            position:LatLng(36.762370,10.268358),
            icon:pinLocationIcon,

          )
      );

      myMarker.add(
          Marker(
            markerId:MarkerId('car19'),
            position:LatLng(36.761235,10.270215),
            icon:pinLocationIcon,

          )
      );

      myMarker.add(
          Marker(
            markerId:MarkerId('car20'),
            position:LatLng(36.761235,10.270215),
            icon:pinLocationIcon,

          )
      );
      myMarker.add(
          Marker(
            markerId:MarkerId('car21'),
            position:LatLng(36.763152,10.272154),
            icon:pinLocationIcon,


          ),

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

      ),

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
            backgroundColor:  Colors.white,
              elevation: 0.0,

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
                      MaterialPageRoute(builder: (context) => SplashScreen()),
                          (route) => false);
                },
              )
            ],
          ),
          drawer: Container(
            child: MenuC(),
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


                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side:BorderSide(color:Colors.white )
                      ),
                        color: Colors.yellow,
                        child: Text("Show",style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.black,fontSize: 20)),
                        onPressed: (){
                          onBottomPressed(context);
                          //saveMarker();
                        }
                    ),
                  ],
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
          return Expanded(
            child: FittedBox(

              child: Container(

                child: Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: Container(
                      height: 400,

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
                            GestureDetector(
                                onTap: calculDistance,
                                child: Text("Hi there ",style: TextStyle(fontSize:14.0),)),
                            Text("Where To ? ",style: TextStyle(fontSize:20.0 ,fontFamily: "Brand-Bold"),),
                            SizedBox(height: 20.0,),
                            GestureDetector(


                                onTap: () {
                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>searchScreen(currentPosition:this.currentPosition,markpos:this.markpos,price:this.price,idx: this.idx,dvEmail: this.dvEmail,)));
                                  //saveRequest();
                                },

                              
                              child: Expanded(
                                child: Container(
                                  height: MediaQuery.of(context).size.height*0.1,
                                 // width: MediaQuery.of(context).size.width*1.5,

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
                                          Text("Search Drop Off ${mark}",style: TextStyle(color:Colors.black54,fontSize: 18.0))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0,),
                            Container(
                              //width: MediaQuery.of(context).size.width*1.5,
                              height: MediaQuery.of(context).size.height*0.1,
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
                                      "Currently Place -   ${addr2} ",style: TextStyle(color:Colors.black54,fontSize: 18.0)
                                  ),
                                  SizedBox(width: 30.0,),

                                ],
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            DividerWidget(),
                            SizedBox(height: 16.0,),



                          ],

                        ),
                      ),
                    )
                ),
              ),
            ),
          );
        });

  }

}