import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'user.dart';

///***** ha4i zeda
class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

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

              child:RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Text(
                  "Start",
                  style: TextStyle(fontSize: 30,color:Color.fromRGBO(255, 171, 64, 1.0)),
                ),
                color: Colors.black,
                splashColor: Color.fromRGBO(240, 160, 50, 1.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.2)),
                onPressed: (){
                 /* Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context)=>user()));*/
                },
              ),

            ),
          ],
        ),
      ),
    );
  }
}
///**** baathtlk c bon behi haw 9a3d nchouf nkaml nrj3 nkhdmhom 3andi w b3d nb3'lk badel w zid elcode ok behy
///