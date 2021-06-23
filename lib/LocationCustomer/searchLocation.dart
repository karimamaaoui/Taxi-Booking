
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi2/HamburgerMenu/Menu.dart';
import 'package:taxi2/splash_screen/enbording_page.dart';

class RequestsList extends StatefulWidget {
  @override
  _RequestsListState createState() => _RequestsListState();
}

class _RequestsListState extends State<RequestsList> with WidgetsBindingObserver {

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
  String email;
  BitmapDescriptor pinLocationIcon;


  GlobalKey <ScaffoldState> scaffoldKey=new GlobalKey<ScaffoldState>();




  @override
  void initState()
  {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    uid = FirebaseAuth.instance.currentUser.uid;
    email = FirebaseAuth.instance.currentUser.email;
    print(uid);
    print(email);
    uid = FirebaseAuth.instance.currentUser.uid;
    //  setSatuts("Online");
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
          etat:value['etat'],
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
  /* void setSatuts(String status)async
  {
    await
    ref.child(uid).update({
      'status':status,
    });

  }
*/
  @override
  bool didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');

    if (state == AppLifecycleState.inactive)
    {
      // setSatuts("Online");
      /// **** ritha ha4i taw  bool isconnect awel may3ml log enti ta3ml update "isconnect" : true mouch hne khtr ma3ndh 3ale9A  bhy
    }
    else
    {
      //   setSatuts("Offline");
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
    double width=MediaQuery.of(context).size.width ;

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
            backgroundColor:Colors.white,
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
                      MaterialPageRoute(builder: (context) => SplashScreen()),
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
                        width: width * 9.0,///***** ha4i zid feha bch yetna7lk eka 5tot safra ha4ika TA3 size na9S
                        padding: EdgeInsets.only(top:50),
                        alignment: Alignment.center,

                        child:  dataList.length==0?
                        Center(child: Text("No Data ",style: TextStyle(color: Colors.lightGreen),)):
                        Container(
                          child: ListView.builder(itemCount: dataList.length,itemBuilder: (_,index)
                          {
                            return CardUi(dataList[index].distance,dataList[index].driver_id,
                              dataList[index].pickup,dataList[index].dropOf,dataList[index].price,dataList[index].ride_email,dataList[index].etat,context,

                            );
                          } ,
                          ),
                        ) ,


                      ),

                    ),

                  ]
              )
          ),

        ));
  }
}

const kLightPrimaryColor = Color(0xFFFFFFFF);

Widget CardUi(double distance,var driver_id,var pickup,var dropOf,var price,var ride_email,var etat,BuildContext ctx)
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
              Colors.amber[300],
              Colors.amber[600]
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
                            style: Theme.of(ctx).textTheme.headline5
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),


                  ),
                  Positioned(
                    width: width*0.80,
                    height: height*0.4,
                    child: Column(
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(top:20.0),
                          child: Row(
                            children: [
                              // SizedBox (width: 20,),
                              Icon(Icons.location_on),
                              Text("Distance ${distance.toStringAsFixed(3)}",
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
                              Text("Pick Up :  \n ${pickup}",style: TextStyle(fontSize: 17,color: kLightPrimaryColor),),
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
                              Text("Destination : \n ${dropOf}",style: TextStyle(fontSize: 17,color: kLightPrimaryColor),),

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
                        SizedBox(
                          height: 12,

                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:10.0),
                          child:
                          Row(
                            children: [
                              Text("Etat Driver: ${etat}",style: TextStyle(fontSize: 20,color: kLightPrimaryColor),),
                              RaisedButton(
                                onPressed: ()
                                {
                                  /*Navigator.of(ctx).push(MaterialPageRoute(
                                      builder: (context) => searchLocation()));*/

                                },
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

          ],
        ),
      ),
    );


}

class Requests
{
  var driver_id,dropOf,pickup,price,ride_email,etat;
  double distance;
  Requests({this.distance,this.driver_id,this.dropOf,this.pickup,this.price,this.ride_email,this.etat});
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