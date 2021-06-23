import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';


///***ha4a masta3mltouch normlment ?? le mastaamltouch
///mela na7it chniya kifh ejb localisation njib fl currentPostion w ki nenzel aal blza fl map nakhou l latlong mteeha w nconverteha l address
///behi ha4ika ta3 list fena page ??
class location_provider extends ChangeNotifierProvider{

  Location _location;
  Location get location=>_location;
  LatLng _locationPosition;
  LatLng get locationPosition=>_locationPosition;

  bool locationServiceActive=true;

  location_provider()
  {
    _location= new Location();

  }

  initialization()async
  {
    await getUserLocation();
  }

  getUserLocation()async
  {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled=await location.serviceEnabled();

    if(!_serviceEnabled)
      {

        _serviceEnabled= await location.requestService();

        if(!_serviceEnabled)
        {
          return;
        }
        _permissionGranted=await location.hasPermission();
        if(_permissionGranted==PermissionStatus.denied)
          {
            _permissionGranted=await location.requestPermission();
            if(_permissionGranted!=PermissionStatus.granted)
              {
               return ; 
              }
          }
      }
    location.onLocationChanged.listen((LocationData currentLoction)
    {
      _locationPosition= LatLng (
          currentLoction.latitude,
          currentLoction.longitude);
      print(_locationPosition);

      //notifyListeners();

    });

  }



}