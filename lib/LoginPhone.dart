import 'package:flutter/material.dart';
import 'OPScreen.dart';
class LoginPhone extends StatefulWidget {

  TextEditingController phoneTextEditingController=TextEditingController();
  LoginPhone( {phoneTextEditingController});

  @override
  _LoginPhoneState createState() => _LoginPhoneState(phoneTextEditingController: phoneTextEditingController);
}

class _LoginPhoneState extends State<LoginPhone> {
  //TextEditingController _controller = TextEditingController();
  TextEditingController phoneTextEditingController=TextEditingController();
  _LoginPhoneState({phoneTextEditingController});


  @override
  Widget build(BuildContext context) {
    void moveToTheLastScreen() {
      Navigator.pop(context);
    };
    return WillPopScope(
      onWillPop: () {
        moveToTheLastScreen();
      },
      child: Scaffold(
      appBar: AppBar(
        title: Text('Phone Auth'),
        backgroundColor: Color.fromRGBO(240, 160, 50, 1.0),
        leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: (){moveToTheLastScreen();}
        ),

      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration:BoxDecoration(image: DecorationImage(image:
        AssetImage('assets/yellow.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.yellow, BlendMode.colorDodge)
              ),
              ),
        child:
          Column(children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              child: Center(
                child:
                Text(
                  'Phone Authentication',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40, right: 10, left: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  prefix: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('+216'),
                  ),
                ),
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller:phoneTextEditingController,

              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: FlatButton(
                color: Colors.yellow,
                textColor: Colors.white,
                child: Container(
                  child: Text("Next",style: TextStyle(fontSize: 18,fontFamily: "Brand Bold"),),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OTPScreen(phoneTextEditingController.text)));
                },
                ),
              ),


          ],
          ),

      ),
    ));
  }
}