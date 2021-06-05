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
                dataList[index].password
            );

          } ,
          ) ,

        )
    );



  }
  /*  @override
    void initState(){
    /*  usersRef2.orderByChild("UserID").equalTo(userc.uid).once()
      .then((DataSnapshot snap) {
        //dataList.clear();
        var keys = snap.value.keys;
        var values = snap.value;
        for (var key in keys) {
          Drivers d = new Drivers(
            values[key]['email'],
            values[key]['name'],
            values[key]['password'],
            values[key]['phone']
          );
          dataList.add(d);
        };
     */
      usersRef2.orderByChild('email').equalTo(userc.email).once().
      then((DataSnapshot snapshot)
      {
        Map<dynamic,dynamic>values=snapshot.value;
        values.forEach((key, value) {
          print(values["name"]);
          print(snapshot.value);

        });

        setState(() {
          super.initState();
          print('Length : ${dataList.length}');
        });
      });
    }
*/

  /* return Scaffold(
      //backgroundColor:k
      // DarkPrimaryColor,
        backgroundColor:Colors.lightGreen,
      appBar: AppBar(
        title:Text('Profile info'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(240, 160, 50, 1.0),


      ),
      body:
      /* dataList.length==0 ?

            Center(
              child:
                Text("no data found")) : ListView.builder(itemCount: dataList.length,itemBuilder: (_,index)
                {
                  return CardUi(dataList[index].name,dataList[index].email,
                      dataList[index].password,dataList[index].phone
                  );

                }
                ),*/
      Container(
          padding: EdgeInsets.only(bottom: 260),
          alignment: Alignment.center,
          margin: EdgeInsets.all(130),
        /*  child: Column(
            children: [
              Text("your email is ${userc.email }",
                style: TextStyle(color: Colors.purple, fontSize: 13, fontFamily: "SegoeBold" ),),

              Text("your name is ${userc.displayName}",
                style: TextStyle(color: Colors.purple, fontSize: 13, fontFamily: "SegoeBold" ),),

              Text("your  is ${userc.toString()}",
                style: TextStyle(color: Colors.purple, fontSize: 13, fontFamily: "SegoeBold" ),),

            ],)*/
          child: Column(
            children: [
              RaisedButton(
                onPressed: (){

                  ref.child("name").once().then((DataSnapshot data)
                  {
                      setState(() {
                        retrieveName=data.value;

                      });
                  });
                },
                child:
                Text("Show",style: TextStyle(fontSize: 25,color: Colors.yellowAccent),),

              ),
              Text(retrieveName)
            ],
          )
           ,
      ),

      // ProfilePic(),
                /*Expanded(
                  child: SizedBox(
                    height: 200.0,
                    child:
                    ListView.builder(itemCount: dataList.length,itemBuilder: (_,index)
                    {
                      return CardUi(dataList[index].email,dataList[index].name,
                          dataList[index].password,dataList[index].phone
                      );

                    }
                    ),
                  ),
                ),*/

        );





  }*/

  Widget CardUi(String name, String email,String password)
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



                  ],
                ),
              ),
            ],
          ),
        ),
      );


  }
}



