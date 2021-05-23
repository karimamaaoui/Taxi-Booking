import 'package:flutter/material.dart';
import 'package:taxi2/Forms/loginDriverForm.dart';
import 'package:taxi2/loginScreenDriver.dart';
import 'loginScreen.dart';

class user extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration:BoxDecoration(image: DecorationImage(image:
        AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken)),
        ),
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text("You are ",style: TextStyle(fontSize: 32,color: Color.fromRGBO(255, 171, 64, 1.0)),),
            ),
            Container(

              child:RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Text(
                  "Customer",
                  style: TextStyle(fontSize: 30,color:Color.fromRGBO(255, 171, 64, 1.0)),
                ),
                color: Colors.black,
                splashColor: Color.fromRGBO(240, 160, 50, 1.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.2)),
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>loginScreen()));
                },
              ),

            ),
            Container(

              child:RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Text(
                  "Driver",
                  style: TextStyle(fontSize: 30,color:Color.fromRGBO(255, 171, 64, 1.0)),
                ),
                color: Colors.black,
                splashColor: Color.fromRGBO(240, 160, 50, 1.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.2)),
                onPressed: (){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context)=>loginScreenDriver()));
                },
              ),

            ),

          ],
        ),
      ),
    );


  }
}

