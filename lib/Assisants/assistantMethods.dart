import 'package:geolocator/geolocator.dart';
import 'package:taxi2/DataHandle/appData.dart';
import 'package:provider/provider.dart';
import 'package:taxi2/Maps/configMaps.dart';
import 'requestAssistant.dart';
import 'package:taxi2/Models/address.dart';

class AssistantMethods
{

/*  String _address = ""; // create this variable

  static Future<String> _getPlace() async {
    Position position;

    List<Placemark> newPlace = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placeMark  = newPlace[0];
    String name = placeMark.name;
    String subLocality = placeMark.subLocality;
    String locality = placeMark.locality;
    String administrativeArea = placeMark.administrativeArea;
    String postalCode = placeMark.postalCode;
    String country = placeMark.country;
    String address = "${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";

    print(address);

  }*/
  static Future<String> searchCoordinateAdress(Position position,context)async
  {

    String placeAdress="";
    String url="https://maps.googleapis.com/maps/api/geocode/json?latlng=${position
        .latitude},${position.
        longitude}&key=$mapKey";

    var response =await RequestAssistant.getRequest(url);

    if (response !="Failed no respone")
      {
        placeAdress = response["results"][0]["formatted_address"];
       // placeAdress = response["results"][0]["address_components"][3]["long_name"];

        Address userPickUpAddress=new Address();
        userPickUpAddress.longitude=position.longitude;
        userPickUpAddress.latitude=position.latitude;
        userPickUpAddress.placeName=placeAdress;

        Provider.of<AppData>(context,listen: false).updatePickUpLocationAddress(userPickUpAddress);

      }

    return placeAdress;

  }

}