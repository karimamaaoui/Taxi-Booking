import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi2/Drivers.dart';
import 'package:taxi2/UsersSide/Profiles/ProfilePic.dart';
import 'Body.dart';
import 'package:taxi2/main.dart';
const kDarkPrimaryColor = Color(0xFF212121);
const kDarkSecondaryColor = Color(0xFF373737);
const kLightPrimaryColor = Color(0xFFFFFFFF);
const kLightSecondaryColor = Color(0xFFF3F7FB);
const kAccentColor = Color(0xFFFFC107);

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  User userc= FirebaseAuth.instance.currentUser;
  final ref=FirebaseDatabase().reference().child("Drivers");
  List <Drivers> dataList=[];
  var retrieveName="";

  @override
  void initState()
  {
    super.initState();
    ref.orderByChild("email").equalTo(userc.email).once().then((DataSnapshot snap)
    {
      var data=snap.value;
      dataList.clear();
      data.forEach((key,value)
      {
        print(value['email']);
        Drivers drivers=new Drivers(

            name: value['name'],
            email:value['email'],
            password: value['password'],
            phone : value['phone'],
          address : value['address'],

        );
        print(key);
        print("qq");
        dataList.add(drivers);
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


          title:Text('Profile info',style: TextStyle(fontFamily: "Signatra"),),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(240, 160, 50, 1.0),
        ),

    body:
      Container(
        padding: EdgeInsets.only(top:50),
        alignment: Alignment.center,

        child:  dataList.length==0?
              Text("No Data ",style: TextStyle(color: Colors.lightGreen),):
            ListView.builder(itemCount: dataList.length,itemBuilder: (_,index)
            {
            return CardUi(dataList[index].name,dataList[index].email,
            dataList[index].password,dataList[index].phone,dataList[index].address
            );

            } ,
      ) ,

    )
    );



  }


  Widget CardUi(String name, String email,String password,String phone,String address)
  {
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
                        child: Row(
                          children: [
                           // SizedBox (width: 20,),
                            Text(name,
                              style: TextStyle(fontSize: 50,
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
                              Text("Email : ${email}",style: TextStyle(fontSize: 20,color: kLightPrimaryColor),),
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
                              Text("Password : ${password} ",style: TextStyle(fontSize: 20,color: kLightPrimaryColor),),
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
                              Text("Mobile Number : ${phone}",style: TextStyle(fontSize: 20,color: kLightPrimaryColor),),
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
                            Text("address : ${address}",style: TextStyle(fontSize: 20,color: kLightPrimaryColor),),
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

