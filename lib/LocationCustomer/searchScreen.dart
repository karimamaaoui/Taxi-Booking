import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:taxi2/Forms/RegisterDriverForm.dart';
import 'package:taxi2/LocationCustomer/ConvertLocation.dart';
import 'package:taxi2/LocationCustomer/LocationC.dart';
import 'package:taxi2/LocationCustomer/listOfCars.dart';
import 'package:taxi2/MainScreen.dart';
import 'package:taxi2/Widget/DividerWidget.dart';
import 'package:taxi2/main.dart';
import 'package:taxi2/splash_screen/enbording_page.dart';
import 'package:url_launcher/url_launcher.dart';

class searchScreen extends StatefulWidget {
  final Position currentPosition;
  final LatLng markpos;
  final String price;
  final String idx;
  final String dvEmail;
  final String dvPhone;
  const searchScreen(
      {Key key,
      this.currentPosition,
      this.markpos,
      this.price,
      this.idx,
      this.dvEmail,
      this.dvPhone})
      : super(key: key);

  @override
  _searchScreenState createState() => _searchScreenState(
      currentPosition: this.currentPosition,
      markpos: this.markpos,
      idx: this.idx,
      dvEmail: this.dvEmail,
      dvPhone: this.dvPhone);
}

class _searchScreenState extends State<searchScreen> {

  final refDr = FirebaseDatabase().reference().child("Drivers");

  double distance;
  Position currentPosition;
  LatLng markpos;
  String price;
  String idx;
  String dvEmail;
  String dvPhone;
  _searchScreenState(
      {this.currentPosition,
      this.markpos,
      this.price,
      this.idx,
      this.dvEmail,
      this.dvPhone});
  calculDistance() async {
    double distanceInMeters = await Geolocator.distanceBetween(
        currentPosition.latitude,
        currentPosition.longitude,
        markpos.latitude,
        markpos.longitude);
    var kilo = distanceInMeters / 1000;
    print(distanceInMeters);
    print(kilo);
    print(currentPosition.toString());
    print(markpos.toString());
    distance = distanceInMeters;
    print(distance);

    if (distanceInMeters <= 300) {
      price = "TND 2500";
    } else if (distanceInMeters > 300 && distanceInMeters <= 600) {
      price = "TND 3000";
    } else if (distanceInMeters > 600 && distanceInMeters <= 1000) {
      price = "TND 4000";
    } else if (distanceInMeters > 1000 && distanceInMeters <= 3000) {
      price = "TND 6000";
    } else if (distanceInMeters > 3000 && distanceInMeters <= 6000) {
      price = "TND 10000";
    } else if (distanceInMeters > 6000 && distanceInMeters < 9000) {
      price = "TND 12000";
    } else if (distanceInMeters > 9000 && distanceInMeters <= 12000) {
      price = "TND 16000";
    } else if (distanceInMeters > 12000 && distanceInMeters <= 20000) {
      price = "TND 20000";
    } else if (distanceInMeters > 20000 && distanceInMeters <= 23500) {
      price = "TND 24000";
    } else {
      price = "TND 28000";
    }

    print(price);
  }

  void cancelRequest() {
    rideRequestRef.remove();
  }

  String addr1, addr2;
  Address addressD2;
  getAddressbasedOnLocation7(currentPosition) async {
    final coordinates =
        new Coordinates(currentPosition.latitude, currentPosition.longitude);
    var addresses3 =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    ConvertLocation()
        .convertCoordinatesToAddress(coordinates)
        .then((value) => addressD2 = value);

    setState(() {
      addr1 = addresses3.first.addressLine;
      addr2 = addresses3.first.addressLine;
      print("jjjjjjjjjjjjjjj ${addr1.toUpperCase()}");
    });
  }

  String uid;
  DatabaseReference rideRequestRef;
  String email = FirebaseAuth.instance.currentUser.email;

  var titeList = [
    "Simple +2 TND",
    "UberX +3 TND",
    "Black +4 Dt",
    "UberXl +5 Dt"
  ];

  var descList = [
    "Adorable races just for you",
    "Luxury races carried out by professional drivers",
    "Luxury races carried out by professional drivers",
    "Adorable races for groups of up to 6 people",
  ];

  var imgList = [
    "assets/images/car11.png",
    "assets/images/car2.png",
    "assets/images/car3.png",
    "assets/images/car4.png",
  ];

  void saveRequest() {
    rideRequestRef =
        FirebaseDatabase.instance.reference().child("Ride Requests").push();

    Map pickUpLocMap = {
      "latitude": currentPosition.latitude.toString(),
      "longitude": currentPosition.longitude.toString(),
    };

    Map dropOffLocMap = {
      "latitude": markpos.latitude.toString(),
      "longitude": markpos.longitude.toString(),
    };

    Map rideInfo = {
      "driver_id": dvEmail,
      "driver_phone": dvPhone,
      "payment_method": "cash",
      "pickup": pickUpLocMap,
      "dropOf": dropOffLocMap,
      "created_at": DateTime.now().toString(),
      "ride_email": email,
      "price": price,
      "distance": distance,
      "carModel": " $idx",
      "etat":"en attente"
    };

    rideRequestRef.set(rideInfo);
  }

  static const colorizeColors = [
    Colors.purple,
    Colors.pink,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 35.0,
    fontFamily: 'Signatra',
  );
  List<Driver> driverList = [];
  var addr;
  FlutterLocalNotificationsPlugin localNotifications;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uid = FirebaseAuth.instance.currentUser.uid;
    print(uid);
    calculDistance();
    var androidInitialize = new AndroidInitializationSettings('ic_launcher');
    //this fct is to initialize android setting it takes as a paremeter icon name
    var initializationSettings =
        new InitializationSettings(android: androidInitialize);
    localNotifications = new FlutterLocalNotificationsPlugin();
    localNotifications.initialize(initializationSettings);

    refDr.once().then((DataSnapshot snap) {
      driverList.clear();
      //var keys=data.value.keys;
      //var values=data.value;
      var data = snap.value;
      driverList.clear();
      data.forEach((key, value) async {
        print(value['email']);
        Driver drivers = new Driver(
          name: value['name'],
          email: value['email'],
          phone: value['phone'],
          status: value['status'],
          address: value['address'],
        );
        driverList.add(drivers);
        //dvEmail=drivers.email;
        //dvPhone=drivers.phone;
        //print('azzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzfdfd ${dvEmail}');
        addr = drivers.address;
        calculDistance();
      });
      setState(() {});
    });
  }

  Future showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "channelId",
        "Local Notification",
        "This is the description of the Notificaiton , you can write anyhing",
        importance: Importance.high);

    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails);
    await localNotifications.show(
        0,
        "Taxi Bibi",
        "Request accpeted please wait for your driver thank you",
        generalNotificationDetails);
  }
  Future showNotification2() async {
    var androidDetails = new AndroidNotificationDetails(
        "channelId",
        "Local Notification",
        "This is the description of the Notificaiton , you can write anyhing",
        importance: Importance.high);

    var generalNotificationDetails =
    new NotificationDetails(android: androidDetails);
    await localNotifications.show(
        0,
        "Taxi Bibi",
        "Canceled Request ",
        generalNotificationDetails);
  }

  void customLauncher(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print("could not launch ${command}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Pick Up Your Car",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SplashScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: SvgPicture.asset(
                "assets/logout-svgrepo-com.svg",
                height: 25,
                width: 20,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 400,
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    "Requesting a Ride",
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    'Make a reservation ',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    'Hurry up',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    "don't waist your Time",
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                //height: 600.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 17.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.amberAccent[100],
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/car.jpg",
                                height: 70.0,
                                width: 80.0,
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MaterialButton(
                                    child: Text(
                                      "Pick up Your Car ",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: "Brand-Bold"),
                                    ),
                                    onPressed: () {
                                      calculDistance();
                                      onBottomPressed(context);
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.moneyCheckAlt,
                                size: 18.0,
                                color: Colors.black54,
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Text("Cash "),
                              SizedBox(
                                width: 16.0,
                              ),
                              Icon(Icons.keyboard_arrow_down,
                                  size: 16.0, color: Colors.black54),
                            ],
                          )),
                      SizedBox(
                        width: 26.0,
                      ),

                             Container(
                               width: double.infinity,
                               color: Colors.amberAccent[100],

                               child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/car.jpg",
                                        height: 70.0,
                                        width: 80.0,
                                      ),
                                      SizedBox(
                                        width: 16.0,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          MaterialButton(
                                              onPressed: () => launch("tel:+216 71 570 906"),
                                              child: new Text("Call Customer services : \n  71 570 906",style: TextStyle(fontSize: 16),)),

                                        ],
                                      )
                                    ],
                                  ),
                                ),
                             ),


                      SizedBox(
                        width: 16.0,
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      AlertDialog(
                        title: Text("You really want to continue"),
                        content: SingleChildScrollView(
                          child: ListBody(children: [
                            SizedBox(
                              width: 16.0,
                            ),

                            SizedBox(
                              height: 10.0,
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: RaisedButton(
                                onPressed: () {
                                  saveRequest();
                                  showNotification();
                                  print('Clicked ');
                                },
                                color: Theme.of(context).accentColor,
                                child: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          child: Text("Request ",
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontFamily: "Brand-Bold",
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Icon(
                                        FontAwesomeIcons.taxi,
                                        color: Colors.black,
                                        size: 18.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),

                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.amberAccent,
                                borderRadius: BorderRadius.circular(26.0),
                              ),

                              child: GestureDetector(
                                child: RaisedButton(
                                    onPressed: () {
                                      cancelRequest();
                                      showNotification2();
                                      print('refuse ');
                                    },

                                  child: Icon(
                                    Icons.close,
                                    size: 24,
                                  )),
                            ),),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              child: Text(
                                "Cancel Ride",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0),
                              ),
                            )
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
  onBottomPressed(BuildContext cxt) {
    double width = MediaQuery.of(context).size.width * 0.6;

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return FittedBox(
            child: Container(
              child: Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: Container(
                    height: 500,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 238, 120, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          topRight: Radius.circular(18.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 16.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 6.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 1.5,
                            height: 300,
                            child: ListView.builder(
                                itemCount: imgList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      showDialougFunct(
                                          context,
                                          imgList[index],
                                          titeList[index],
                                          descList[index],
                                          driverList[index].name,
                                          driverList[index].phone);
                                      idx = titeList[index];
                                      dvEmail = driverList[index].email;
                                      dvPhone = driverList[index].phone;
                                    },
                                    child: Card(
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 100,
                                            width: 100,
                                            child: Image.asset(imgList[index]),
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    titeList[index],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    width: width,
                                                    child: Text(
                                                      descList[index],
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.grey[500],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    width: width,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          driverList[index]
                                                              .name,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors
                                                                .grey[500],
                                                          ),
                                                        ),
                                                        Text(
                                                          driverList[index]
                                                              .phone,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors
                                                                .grey[500],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          DividerWidget(),
                        ],
                      ),
                    ),
                  )),
            ),
          );
        });
  }

  showDialougFunct(context, img, title, desc, String name, String phone) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white),
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * 0.89,
                height: 420,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRect(
                      child: Image.asset(
                        img,
                        width: 200,
                        height: 200,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      desc,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[500],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      child: Row(
                        children: [
                          // SizedBox (width: 20,),
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 30,
                                color: kLightPrimaryColor,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -1),
                          ),
                          SizedBox(
                            height: 12,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  phone,
                                  style: TextStyle(
                                      fontSize: 20, color: kLightPrimaryColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    RaisedButton(
                      child: Text("Choose it ${this.price}  "),
                      onPressed: () {
                        calculDistance();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => searchScreen(
                                currentPosition: this.currentPosition,
                                markpos: this.markpos,
                                price: this.price,
                                idx: this.idx,
                                dvEmail: this.dvEmail,
                                dvPhone: this.dvPhone)));
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static const kLightPrimaryColor = Color(0xFFFFFFFF);
}
