import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taxi2/MainScreen.dart';

class searchScreen extends StatefulWidget {
  @override
  _searchScreenState createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {


  @override
  Widget build(BuildContext context) {
    void moveToTheLastScreen()
    {
      Navigator.pop(context);
    };

    return WillPopScope(
        onWillPop :(){
          moveToTheLastScreen();
        },

        child: Scaffold(
            appBar: AppBar(title: Text(''),
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


      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

        Positioned(
        bottom: 0.0,
        left: 0.0,
        right:0.0,
        child: Container(
          height: 300.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft:Radius.circular(16.0),topRight:Radius.circular(16.0) ),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 16.0,
                spreadRadius: 0.5,
                offset:Offset(0.7,0.7),

              )
            ],
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 17.0),
            child: Column(
              children: [
                Container(
                  width:double.infinity,
                  color: Colors.tealAccent[100],
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal:16.0),
                    child: Row(
                      children: [
                        Image.asset("assets/images/car.jpg",height:70.0,width: 80.0 ,),
                        SizedBox(width: 16.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Car",style: TextStyle(fontSize: 18.0,fontFamily: "Brand-Bold"),)

                          ],
                        )
                      ],
                    ),

                  ),
                ),
                SizedBox(height:20.0 ,),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child:Row(
                      children: [
                        Icon(FontAwesomeIcons.moneyCheckAlt,size:18.0,color: Colors.black54,),
                        SizedBox(width: 16.0,),
                        Text("Cash"),
                        SizedBox(width: 16.0,),
                        Icon(Icons.keyboard_arrow_down,size:16.0,color:Colors.black54),


                      ],
                    )
                ),
                SizedBox(width: 16.0,),
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      print('Clicked');
                    },
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Request",style: TextStyle(fontSize: 20.0,fontFamily: "Brand-Bold",color: Colors.white,fontWeight: FontWeight.bold)),
                          Icon(FontAwesomeIcons.taxi,color:Colors.black, size: 18.0,),
                        ],
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),

      ),
        ],
      ),)
    );

  }
}
