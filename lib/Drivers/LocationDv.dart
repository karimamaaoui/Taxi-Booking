
import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi2/Assisants/assistantMethods.dart';
import 'package:taxi2/HamburgerMenu/Menu.dart';
import 'package:taxi2/LocationCustomer/ConvertLocation.dart';
import 'package:taxi2/MainScreen.dart';

class LocationDv extends StatefulWidget {
  @override
  _LocationDvState createState() => _LocationDvState();
}

class _LocationDvState extends State<LocationDv> with WidgetsBindingObserver {

  final ref=FirebaseDatabase().reference().child("Drivers");
  final rideRequestRef=FirebaseDatabase().reference().child("Ride Requests");
  List <Requests> dataList=[];

  Address addressC;
  Address addressD2;
  Position currentPosition;
  var geoLocator=Geolocator();
  String addr1="";
  String addr2="";
  String uid;
  String uid1="M794EDCuq4VkKhUrGt2x4lgwbpx2";
  String uid2="PaP8fhgkxnOwsCz8eOo4SQibyWS2";
  String uid3="Pd8vlLiYySVIoid6VBFq9yLXtAG3";
  String uid4="a3jVvPUqhogkzKMVpMoazhZPgvB3";
  String uid5="m32IRXqjF1PqACc8nv6560gvuhO2";
  String email;
  BitmapDescriptor pinLocationIcon;


GlobalKey <ScaffoldState> scaffoldKey=new GlobalKey<ScaffoldState>();


  getAddressbasedOnLocation1() async
  {
    final coordinates = new Coordinates(36.727328,10.342544);
    var addresses =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    ConvertLocation().convertCoordinatesToAddress(coordinates).then((value) =>
    addressC = value);

    setState(() {
      addr2 = addresses.first.addressLine;
      print(addr1);

      ref.child(uid1).update({
        'address':"${addr2}"
      });

    });
  }


  getAddressbasedOnLocation2() async
  {
    final coordinates= new Coordinates(36.802412,10.175117);
    var addresses2 =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    ConvertLocation().convertCoordinatesToAddress(coordinates).then((value) =>
    addressD2 = value);



    setState(() {
      addr1 = addresses2.first.addressLine;
      addr2 = addresses2.first.addressLine;
      print(addr1);

      ref.child(uid2).update({
        'address':"${addr2}"
      });

    });
  }

  getAddressbasedOnLocation3() async
  {
    final coordinates= new Coordinates(36.761235,10.270215);
    var addresses3 =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    ConvertLocation().convertCoordinatesToAddress(coordinates).then((value) =>
    addressD2 = value);



    setState(() {
      addr1 = addresses3.first.addressLine;
      addr2 = addresses3.first.addressLine;
      print(addr1);

      ref.child(uid3).update({
        'address':"${addr2}"
      });

    });
  }
  getAddressbasedOnLocation4() async
  {
    final coordinates= new Coordinates(36.763152,10.272154);
    var addresses3 =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    ConvertLocation().convertCoordinatesToAddress(coordinates).then((value) =>
    addressD2 = value);



    setState(() {
      addr1 = addresses3.first.addressLine;
      addr2 = addresses3.first.addressLine;
      print(addr1);

      ref.child(uid4).update({
        'address':"${addr2}"
      });

    });
  }

  getAddressbasedOnLocation5() async
  {
    final coordinates= new Coordinates(36.761235,10.270215);
    var addresses3 =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    ConvertLocation().convertCoordinatesToAddress(coordinates).then((value) =>
    addressD2 = value);



    setState(() {
      addr1 = addresses3.first.addressLine;
      addr2 = addresses3.first.addressLine;
      print(addr1);

      ref.child(uid5).update({
        'address':"${addr2}"
      });

    });
  }


  @override
    void initState()
    {    
      WidgetsBinding.instance.addObserver(this);
      super.initState();
      uid = FirebaseAuth.instance.currentUser.uid;
      email = FirebaseAuth.instance.currentUser.email;
      print(uid);
      print(email);
      getAddressbasedOnLocation1();
      getAddressbasedOnLocation2();
      getAddressbasedOnLocation3();
      getAddressbasedOnLocation4();
      getAddressbasedOnLocation5();
      uid = FirebaseAuth.instance.currentUser.uid;
      setSatuts("Online");
      rideRequestRef.orderByChild("driver_id").equalTo(email).once().then((DataSnapshot snap)
      {
        var data=snap.value;
        dataList.clear();
        data.forEach((key,value)
        {
          print(value['email']);
          Requests requests=new Requests(
            distance:value['distance'],
            driver_id: value['driver_id'],
            pickup : value['pickup'],
            dropOf: value['dropOf'],
            price : value['price'],
            ride_email : value['ride_email'],

          );
          print(key);
          print("qq");
          print("aalllllllllllllllaa ${dataList.length}");
          dataList.add(requests);
        });
        setState(() {

        });

      });


    }
  void setSatuts(String status)async
  {
    await
    ref.child(uid).update({
      'status':status,
    });

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');

    if (state == AppLifecycleState.inactive)
    {
      setSatuts("Online");
    }
    else
    {
      setSatuts("Offline");
    }
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  User userc= FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

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
        onPressed: ()
          {moveToTheLastScreen();}
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
                Center(
                  child: Container(
                    height: height*0.7,
                    width: width* 0.88,
                    padding: EdgeInsets.only(top:50),
                    alignment: Alignment.center,

                    child:  dataList.length==0?
                    Text("No Data ",style: TextStyle(color: Colors.lightGreen),):
                    ListView.builder(itemCount: dataList.length,itemBuilder: (_,index)
                    {
                      return CardUi(dataList[index].distance,dataList[index].driver_id,
                          dataList[index].pickup,dataList[index].dropOf,dataList[index].price,dataList[index].ride_email,context
                      );

                    } ,
                    ) ,

                  ),
                )

              ]
      )
      ),

      ));
    }
}
const kLightPrimaryColor = Color(0xFFFFFFFF);

Widget CardUi(double distance,var driver_id,var pickup,var dropOf,var price,var ride_email,BuildContext ctx)
{
  double height=MediaQuery.of(ctx).size.height;
  double width=MediaQuery.of(ctx).size.width;
  return
    Card(
      clipBehavior: Clip.antiAlias,
      shadowColor: Colors.amber,
      elevation: 8,
      margin: EdgeInsets.all(30),
      shape:RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(16),
      ),
      child: Container(
        //color: kDarkSecondaryColor,
        margin: EdgeInsets.all(1.5),
        padding: EdgeInsets.only(top:30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:[
              Colors.amber[900],
              Colors.amber[700]
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),

              child: Column(
                children: [
                   CustomPaint(
                      size:Size(100,100),
                      painter:CardCustomPaint(

                      ),
                     child:Column(
                       children: [
                         Positioned(
                           bottom: 10,
                           left: 10,
                           child: Image.asset(
                             'assets/images/img.png',
                             color: Colors.red.withOpacity(0.3),
                             width: width*0.5 ,
                           ),
                         ),
                     SizedBox(
                       height: 30,
                     ),
                     Center(
                       child: Image.asset(
                         'assets/images/eye.png',
                         color: Colors.white70,
                         width: width * 0.25,
                       ),),
                         Text(
                           'Requests List',
                           style: TextStyle(
                             color: Colors.black,
                             fontSize: 25,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         SizedBox(
                           height: 10,
                         ),
                       ],
                     ),


                  ),
                  Positioned(
                    width: width*0.3,
                    height: height*0.4,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 12,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top:10.0),
                          child: Row(
                            children: [
                              // SizedBox (width: 20,),
                              Icon(Icons.location_on),
                              Text("Distance ${distance}",
                                style: TextStyle(fontSize: 20,
                                    color: kLightPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -1
                                ),),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,

                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:10.0),
                          child:
                          Row(
                            children: [
                              Text(driver_id,style: TextStyle(fontSize: 20,color: kLightPrimaryColor),),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top:10.0),
                          child:
                          Row(
                            children: [
                              Text("PickUP : ${pickup} ",style: TextStyle(fontSize: 20,color: kLightPrimaryColor),),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 12,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top:10.0),
                          child:
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Destination : \n ${dropOf}",style: TextStyle(fontSize: 20,color: kLightPrimaryColor),),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top:10.0),
                          child:
                          Row(
                            children: [
                              Text("price : ${price }",style: TextStyle(fontSize: 20,color: kLightPrimaryColor),),
                            ],
                          ),
                        ),
                        Padding(

                          padding: const EdgeInsets.only(top:10.0),
                          child:
                          Row(

                            children: [
                              Icon(Icons.email),

                              Text(" Ride Email : \n ${ride_email}:",style: TextStyle(fontSize: 20,color: kLightPrimaryColor),),

                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );


}

class Requests
{
  var driver_id,dropOf,pickup,price,ride_email;
  double distance;
  Requests({this.distance,this.driver_id,this.dropOf,this.pickup,this.price,this.ride_email});
}

class CardCustomPaint extends CustomPainter{
 @override
 void paint(Canvas canvas,Size size)
 {
    Paint paint =new Paint()
    ..color=Colors.black
        ..style=PaintingStyle.fill;
    Path path=Path();
    path.moveTo(0,0 );
    path.lineTo(0, size.height*0.32);
    path.quadraticBezierTo(size.width*0.24,
        size.height*0.45,
        size.width*0.49,
        size.height*0.45);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    canvas.drawPath(path, paint);
 }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
  return true;
    }
}