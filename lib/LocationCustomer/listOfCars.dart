import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi2/Drivers.dart';
import 'package:taxi2/LocationCustomer/searchScreen.dart';
class listOfCars extends StatefulWidget {

    final Position currentPosition;
  final LatLng markpos;
  final String price;
  final String idx;
  final String dvEmail;
  final String dvPhone;
  const listOfCars({this.currentPosition, this.markpos,this.price, this.idx,this.dvEmail,this.dvPhone});

  @override
  _listOfCarsState createState() => _listOfCarsState(currentPosition:this.currentPosition,markpos:this.markpos,idx: this.idx,dvEmail:this.dvEmail,dvPhone:this.dvPhone);
}



class _listOfCarsState extends State<listOfCars> {

  Position currentPosition;
  LatLng markpos;
  String price;
  String idx;
  String dvEmail;
  String dvPhone;
  _listOfCarsState({this.currentPosition,this.markpos,this.price,this.idx,this.dvEmail,this.dvPhone});


  convert()async
  {
    final query = addr;
    var addrLatLg = await Geocoder.local.findAddressesFromQuery(query);
    var first = addrLatLg.first;
    print("${first.featureName} : ${first.coordinates}");



  }
double distance;
  calculDistance()async
  {

    final query = addr;
    var addrLatLg = await Geocoder.local.findAddressesFromQuery(query);
    var first = addrLatLg.first;
    print("${first.featureName} : ${first.coordinates}");


    double distanceInMeters = await Geolocator.distanceBetween(
        currentPosition.latitude,
        currentPosition.longitude,
      first.coordinates.latitude,first.coordinates.longitude

    );
    var kilo = distanceInMeters / 1000;
    print(distanceInMeters);
    print(kilo);
    print(currentPosition.toString());
    print(markpos.toString());
    distance = distanceInMeters;
    print(distance);
  }

    final ref = FirebaseDatabase().reference().child("Drivers");
  static const kDarkPrimaryColor = Color(0xFF212121);
  static const kDarkSecondaryColor = Color(0xFF373737);
  static const kLightPrimaryColor = Color(0xFFFFFFFF);
  List<Driver> driverList=[]; var addr;

var addrLatLg;
var driver1;
  @override
  void initState() {
    super.initState();

    ref.once().then((DataSnapshot snap)
    {
     driverList.clear();
     //var keys=data.value.keys;
     //var values=data.value;
     var data=snap.value;
     driverList.clear();
     data.forEach((key,value)
     async {
       print(value['email']);
       Driver drivers=new Driver(

         name: value['name'],
         email:value['email'],
         phone : value['phone'],
         status : value['status'],
         address:value['address'],
       );
       driverList.add(drivers);
       dvEmail=drivers.email;
       dvPhone=drivers.phone;
       print('fdfd ${dvEmail}');
       addr=drivers.address;
       calculDistance();
     });
     setState(() {

     });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:kDarkPrimaryColor,
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient:new LinearGradient(
                colors:[Color.fromRGBO(250, 184, 50, 1),Color.fromRGBO(253,235,197,1)],
                begin: const FractionalOffset(0.0,0.0),
                end: const FractionalOffset(1.0,0.0),
                stops: [0.0,1.0],
                tileMode: TileMode.clamp,

              ),
            )
        ),


        title:Text('List of Dirvers',style: TextStyle(fontFamily: "Signatra"),),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(240, 160, 50, 1.0),
      ),
      body: driverList.length==0?
      Center(child: Text("no data available",style: TextStyle(color:kLightPrimaryColor),)):

      ListView.builder(itemCount: driverList.length,itemBuilder: (_,index)
    {
      dvEmail=driverList[index].email;
      print("ka ${dvEmail}");

      return CardUi(driverList[index].name,driverList[index].email,
          driverList[index].phone,driverList[index].status,driverList[index].address

      );

    } ,
    ) ,
    );

  }


  Widget CardUi(String name, String email,String phone,String status,String address)
  {
    dvPhone=phone;
    dvEmail=email;
    print('karima ${dvEmail}');
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
          width: MediaQuery.of(context).size.width*0.3,

          //color: kDarkSecondaryColor,
          margin: EdgeInsets.all(1.5),
          padding: EdgeInsets.only(top:30),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:[Colors.amber,Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Positioned(
                width: 80,
                height: 100,
                child: Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top:10.0),

                      child: Expanded(
                        child: Container(

                          child: Row(
                            children: [

                              // SizedBox (width: 20,),
                              Text(name,
                                style: TextStyle(fontSize: 30,
                                    color:kLightPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -1
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,

                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:10.0),
                      child:
                      Expanded(
                        child: Row(
                          children: [
                            Text("Email : ${email}",style: TextStyle(fontSize: 20,color: kLightPrimaryColor),),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 12,
                    ),

                    SizedBox(
                      height: 12,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top:10.0),
                      child:
                      Row(
                        children: [
                          Text("phone : ${phone} ",style: TextStyle(fontSize: 20,color: kLightPrimaryColor),),
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
                          Text("status : ${status}",style: TextStyle(fontSize: 20,color: kLightPrimaryColor),),
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
                          Text("address :",style: TextStyle(fontSize: 20,color: kLightPrimaryColor),),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:10.0),
                      child:
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.5,

                          child: Text(" ${address}",style: TextStyle(fontSize: 17,color: kLightPrimaryColor),)),

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

                          RaisedButton(
                           child: Text("Choose one ",style: TextStyle(fontSize: 20,color: kLightPrimaryColor),),

                        onPressed:
                              () {
                               // dvEmail=email;
                                dvPhone=phone;
                               /* Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>searchScreen(currentPosition:this.currentPosition,markpos:this.markpos,price:this.price,idx: this.idx,dvEmail: dvEmail,dvPhone: this.dvPhone,)));
                             */ },

                          )
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
}
class Driver
{ String email, name, phone, status,address;

Driver({this.name, this.email, this.phone, this.status,this.address});
}
