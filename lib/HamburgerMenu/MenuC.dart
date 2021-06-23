import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taxi2/MainScreen.dart';
import 'package:taxi2/UsersSide/Profiles/Body.dart';
import 'package:taxi2/Widget/DividerWidget.dart';
import 'file:///C:/Users/asus/AndroidStudioProjects/taxi2/lib/UsersSide/Profiles/ProfileScreen.dart';
import 'package:taxi2/splash_screen/enbording_page.dart';

class MenuC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                height: 165.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Image.asset("assets/images/user_icon.png",height: 65.0,width: 65.0,),
                      SizedBox(width: 16.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Profile Name",style: TextStyle(fontSize: 16.0,fontFamily: "Brand-Bold"),),
                          SizedBox(height: 6.0,),
                        ],
                      )
                    ],
                  ),
                ),

              ),
              DividerWidget(),
              SizedBox(height:12.0),

              //drawer body Controller
              ListTile(leading: Icon(Icons.history),
                title: Text("History",style: TextStyle(fontSize: 15.0,)),
                onTap :()=>selectedItems(context,0) ,

              ),

              ListTile(leading: Icon(Icons.person),
                title: Text("Visit Profile",style: TextStyle(fontSize: 15.0,)),
                onTap :()=>selectedItems(context,1) ,
              ),

              ListTile(leading: Icon(Icons.info),
                title: Text("About ",style: TextStyle(fontSize: 15.0,)),
                onTap :()=>selectedItems(context,2) ,

              ),
              GestureDetector(
                onTap: (){
                  FirebaseAuth.instance.signOut();
                },
                child: ListTile(leading: Icon(Icons.transit_enterexit),
                  title: Text("Sign out ",style: TextStyle(fontSize: 15.0,)),
                  onTap :()=>selectedItems(context,3) ,

                ),
              )
            ],
          ),
        ),


    );
  }

  selectedItems(context, int index)
  {
    switch(index){
      case 0:

        Navigator.push(context,
            MaterialPageRoute(builder: (context)=>Body()));

        break;
      case 1:

        Navigator.push(context,
            MaterialPageRoute(builder: (context)=>Body()));

        break;
      case 2:

        Navigator.push(context,
            MaterialPageRoute(builder: (context)=>Body()));

        break;

      case 3:

        Navigator.push(context,
            MaterialPageRoute(builder: (context)=>SplashScreen()));

        break;

    }

  }
}
