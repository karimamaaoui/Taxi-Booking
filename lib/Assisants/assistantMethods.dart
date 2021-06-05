
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:taxi2/DataHandle/AppData.dart';
import 'package:taxi2/Maps/configMaps.dart';
import 'package:taxi2/Models/address.dart';
import 'package:taxi2/UsersSide/Profiles/Customers.dart';

class AssistantMethods
{

static Future<String> getPlace(Position position,context)async
{

String placeAdress="";
String st1,st2,st3,st4;


Address userPickUpAddress=new Address();
userPickUpAddress.longitude=position.longitude;
userPickUpAddress.latitude=position.latitude;
userPickUpAddress.placeName=placeAdress;


Provider.of<AppData>(context,listen: false).updatePickUpLocationAddress(userPickUpAddress);
print(userPickUpAddress);
}




}