import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi2/Drivers.dart';
import 'package:taxi2/LocationCustomer/LocationC.dart';
import 'package:taxi2/LoginPhone.dart';
import 'package:taxi2/MainScreen.dart';
import 'package:taxi2/UsersSide/Profiles/Body.dart';
import 'package:taxi2/UsersSide/Profiles/ProfileScreen.dart';
import 'package:taxi2/Drivers/LocationDv.dart';
class DriverHome extends StatefulWidget {
  @override
  _DriverHomeState createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> with WidgetsBindingObserver {

  List <Drivers> dataList=[];
  User userc= FirebaseAuth.instance.currentUser;
  final ref=FirebaseDatabase().reference().child("Drivers");


  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    uid = FirebaseAuth.instance.currentUser.uid;
   // setSatuts("Online");

  }
/*
  void setSatuts(String status)async
    {
      await
    ref.child(uid).update({
      'status':status
    });

  }

*/
/*
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //print('state = $state');

    if (state == AppLifecycleState.inactive)
      {
        setSatuts("Online");
      }
    else
      {
        setSatuts("Offline");
      }
  }
*/
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  String uid;
  @override
  Widget build(BuildContext context) {
    final urlImage='assets/locationservice.jpg';
    void moveToTheLastScreen()
    {
      Navigator.pop(context);
    };
    return WillPopScope(
      onWillPop :(){
        moveToTheLastScreen();
      },

      child: Scaffold(
        appBar: AppBar(title: Text("Home"),
          backgroundColor: Color.fromRGBO(240, 160, 50, 1.0),
          leading: IconButton(icon: Icon(Icons.arrow_back),
              onPressed: (){moveToTheLastScreen();}
          ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                      (route) => false);
            },
          )
        ],
        ),

        body: Container(
        padding: EdgeInsets.all(14.0),
        height: double.infinity,
        width: double.infinity,
        decoration:BoxDecoration(image: DecorationImage(image:
        AssetImage('assets/yellow.jpg'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(Colors.yellow, BlendMode.colorDodge)
        ),
        ),
        child : SingleChildScrollView(
          child:Column(
            children:[
              Container(
                child: Center(
                  child:
                  Text("Allow location service",style: TextStyle(fontSize: 30,color: Colors.black45),),
                ),

              ),
              SizedBox(height: 50.0,),
              Container(
                child:Image(
                  image: AssetImage(urlImage),
                  width:500,
                  //height:300.0,
                  alignment:Alignment.center,
                  fit: BoxFit.fill,
                ),

              ),
              SizedBox(height: 80.0,),

              Container(
                child: Container(
                  child:
                  Text("To show the reservation",style: TextStyle(fontSize: 20,color: Colors.black45),),
                ),
              ),
              Container(
                margin: EdgeInsets.all(30.0),
                width: double.infinity,
                child: FlatButton(
                  color: Colors.yellow,
                  textColor: Colors.white,
                  child: Container(
                    child: Text("Allow",style: TextStyle(fontSize: 18,fontFamily: "Brand Bold"),),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>LocationDv()));
                  },
                ),
              ),


            ],

          ) ,


        )
        ),
    )
    );
  }

}