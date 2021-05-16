
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:taxi2/DataHandle/AppData.dart';

import 'package:taxi2/Models/address.dart';

class AssistantMethods
{

static Future<String> getPlace(Position position,context)async
{

String placeAdress="";

Address userPickUpAddress=new Address();
userPickUpAddress.longitude=position.longitude;
userPickUpAddress.latitude=position.latitude;
userPickUpAddress.placeName=placeAdress;

Provider.of<AppData>(context,listen: false).updatePickUpLocationAddress(userPickUpAddress);
print(userPickUpAddress);
}




}