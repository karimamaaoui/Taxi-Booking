
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_maps_webservice/places.dart';

import 'MainScreen.dart';
import 'Drivers.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
List<Drivers> dataList=[];
DatabaseReference usersRef=FirebaseDatabase.instance.reference().child("Customers");
DatabaseReference usersRef2=FirebaseDatabase.instance.reference().child("Drivers");
DatabaseReference rideRequest=FirebaseDatabase.instance.reference().child("Ride Request");



const kGoogleApiKey = "AIzaSyCgNdI4otkEM7ONrqh2BbUQ8TTDIosMUhk";

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);


class MyApp extends StatefulWidget {
static void setLocale(BuildContext context, Locale newlocale)
{
  _MyAppState state=context.findRootAncestorStateOfType<_MyAppState>();
}
  @override

  _MyAppState createState()=>_MyAppState();
}
class  _MyAppState extends State<MyApp>
{

  @override
  Widget build(BuildContext flcontext) {
    return
       GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Main ',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
       // initialRoute: FirebaseAuth.instance.currentUser==null ? user():MainScreen().key,
        home: MainScreen(),
      );
  }
}
