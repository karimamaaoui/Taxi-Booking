import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:taxi2/LocationCustomer/ConvertLocation.dart';

class searchLocation extends StatefulWidget {
  @override
  _searchLocationState createState() => _searchLocationState();
}


class _searchLocationState extends State<searchLocation> {


  final LatLng Tatouine = const LatLng(32.93333,10.45000);
  String addrTat="";

  getTatouine() async{
    Address addressC;

    final coordiTataouine = new Coordinates(Tatouine.latitude, Tatouine.longitude);
      var addresses =
      await Geocoder.local.findAddressesFromCoordinates(coordiTataouine);
      ConvertLocation().convertCoordinatesToAddress(coordiTataouine).then((
          value) => addressC = value);

      setState(() {
        addrTat = addresses.first.addressLine;
        print(addrTat);
      });

  }
  @override
  void initState()
  {
    super.initState();
    getTatouine();
  }


  @override
    Widget build(BuildContext context) {

      return Scaffold(
        body: Column(
          children: [

            Container(
              height: 150.0,
              decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7,0.7),

                    )
                  ]
              ),
              child:Container(
                    child: Center(
                      child:
                      Text(" ${addrTat}",style: TextStyle(fontSize:18.0 ,fontFamily: "Brand-Bold",color: Colors.red),),

                    ),

                ),
              ),

          ],
        ),
      );
    }
}
