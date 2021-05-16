
import 'dart:async';

import 'package:geocoder/geocoder.dart';

class ConvertLocation {


  Future<Address>convertCoordinatesToAddress( Coordinates coordinates)async
  {
    var addresses=await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first;
  }
}