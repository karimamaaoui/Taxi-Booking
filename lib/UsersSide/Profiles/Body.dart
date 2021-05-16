import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi2/UsersSide/Profiles/Customers.dart';
import 'package:taxi2/UsersSide/Profiles/ProfilePic.dart';
import 'package:taxi2/main.dart';

const kDarkPrimaryColor = Color(0xFF212121);
const kDarkSecondaryColor = Color(0xFF373737);
const kLightPrimaryColor = Color(0xFFFFFFFF);
const kLightSecondaryColor = Color(0xFFF3F7FB);
const kAccentColor = Color(0xFFFFC107);

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  User userc= FirebaseAuth.instance.currentUser;
  final ref=FirebaseDatabase().reference().child("Customers");
  List <Customers> dataList=[];
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
        Customers customers=new Customers(
          email:value['email'],
          name: value['name'],
          password: value['password'],
        );
        print(key);
        print("ok");
        dataList.add(customers);
      });
      setState(() {

      });

    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:kLightPrimaryColor,

      appBar: AppBar(
          title:Text('Customers info'),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(240, 160, 50, 1.0),
        ),
        body:

            Container(

              child:
              ListView.builder(itemCount: dataList.length,itemBuilder: (_,index)
              {
                return CardUi(dataList[index].email,dataList[index].name,
                    dataList[index].password
                );

              } ,
              ) ,

            ),

    );

  }
  Widget CardUi(String email, String name,String password)
  {
    return Card(
        elevation: 7,
        margin: EdgeInsets.all(15),
    color: Color(0xffff2fc3),
    child: Container(
    color: Colors.grey,
    margin: EdgeInsets.all(1.5),
    padding: EdgeInsets.all(10),

    child: Column(
          children: [
            SizedBox(
              height: 1,
            ),

            Text(email,style: TextStyle(fontSize: 25,color: Colors.white),),
            SizedBox(
              height: 1,
            ),

            Text(name,style: TextStyle(fontSize: 25,color: Colors.white),),
            SizedBox(
              height: 1,

            ),

            Text(password,style: TextStyle(fontSize: 25,color: Colors.white),),
            SizedBox(
              height: 1,
            ),



          ],
        ),
      )
    );

  }
}

